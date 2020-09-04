#include <optimized/const_math.h>
#include <timing/thread_helper.h>
#include <timing/timers.h>
#include <util/arg.h>
#include <util/verbosity.h>

#include <allocator/rseq/rseq_base.h>
#include <allocator/slab_layout/create_slab_type.h>
#include <allocator/slab_layout/slab_manager.h>

#include <unordered_map>

#define MALLOC
#ifdef MALLOC
#define ALLOCATOR malloc_allocator
#else
#define ALLOCATOR slab_allocator
#endif


uint32_t test_size = (1 << 20);

float delete_rate    = 0.0;
float delete_success = 1.0;

uint32_t query_per_insert = 0;
float    query_success    = 1.0;

float insert_success = 1.0;


uint32_t nthread = 1;

const uint32_t msize              = 256;
uint32_t       bucket_list[msize] = { 0 };

template<typename T = uint64_t>
struct metrics_allocator {
    using value_type = T;

    template<typename U>
    metrics_allocator(const metrics_allocator<U> &) {}

    metrics_allocator() = default;

    T *
    allocate(size_t n) {
        if (n < msize) {
            ++bucket_list[n];
        }
        T * tmp = (T *)malloc(n * sizeof(uint64_t));
        return tmp;
    }

    void
    deallocate(T * p, size_t n) {
        (void)(n);
        free((void *)p);
    }
};


// typedef uint64_t nbytes_56;

typedef struct nbytes {
    uint64_t padding[1];
} nbytes_56;

using allocator_t = slab_manager<
    nbytes_56,
    super_slab<nbytes_56, super_slab<nbytes_56, slab<nbytes_56>, 1>, 1>>;

allocator_t * my_allocator = NULL;

__thread uint64_t alloc_time = 0;
__thread uint64_t free_time  = 0;

template<typename T = uint64_t>
struct malloc_allocator {
    using value_type = T;

    template<typename U>
    malloc_allocator(const malloc_allocator<U> &) {}

    malloc_allocator() = default;

    T *
    allocate(size_t n) {
        uint64_t start = timers::get_cycles();
        T *      p     = (T *)malloc(n * sizeof(uint64_t));
        alloc_time += (timers::get_cycles() - start);
        return p;
    }

    void
    deallocate(T * p, size_t n) {
        uint64_t start = timers::get_cycles();
        (void)(n);
        free(p);
        free_time += (timers::get_cycles() - start);
    }
};

template<typename T = uint64_t>
struct slab_allocator {
    using value_type = T;

    template<typename U>
    slab_allocator(const slab_allocator<U> &) {}

    slab_allocator() = default;

    T *
    allocate(size_t n) {
        uint64_t start = timers::get_cycles();
        if (BRANCH_LIKELY(n == 1)) {
            void * p = (void *)my_allocator->_allocate();
            if (BRANCH_LIKELY(p != NULL)) {
                alloc_time += (timers::get_cycles() - start);
                return (T *)p;
            }
        }


        T * p = (T *)malloc(n * sizeof(uint64_t));
        alloc_time += (timers::get_cycles() - start);
        return p;
    }

    void
    deallocate(T * p, size_t n) {
        uint64_t start = timers::get_cycles();
        (void)(n);
        const uint64_t _p = (uint64_t)p;
        if (_p > (uint64_t)(my_allocator->m) &&
            _p < (uint64_t)(my_allocator->m + 1)) {
            my_allocator->_free((nbytes_56 *)p);
        }
        else {
            free((void *)p);
        }
        free_time += (timers::get_cycles() - start);
    }
};

using pmap = std::unordered_map<uint64_t,
                                uint64_t,
                                std::hash<uint64_t>,
                                std::equal_to<uint64_t>,
                                ALLOCATOR<uint64_t>>;
typedef struct thread_args {
    uint64_t * ikeys;
    uint64_t * qkeys;
    uint64_t * dkeys;

    pmap * hset;
} targs_t;

uint64_t          total_nsec       = 0;
uint64_t          total_alloc_time = 0;
uint64_t          total_free_time  = 0;
pthread_barrier_t b;

void *
test_hset(void * args) {
    total_alloc_time = 0;
    total_free_time  = 0;
    total_nsec       = 0;

    init_thread();
    targs_t * targs = (targs_t *)args;

    const uint64_t * const ikeys = targs->ikeys;
    const uint64_t * const qkeys = targs->qkeys;
    const uint64_t * const dkeys = targs->dkeys;

    pmap * hset = targs->hset;

    const uint32_t _test_size        = test_size;
    const uint32_t _query_per_insert = query_per_insert;
    const uint32_t _delete_every_niter =
        delete_rate == 0.0 ? 0 : 1 / delete_rate;

    uint32_t q_idx = 0, d_idx      = 0;
    uint32_t q_temp, should_delete = 1;

    struct timespec start_ts, end_ts;

    pthread_barrier_wait(&b);


    timers::gettime(timers::ELAPSE, &start_ts);
    for (uint32_t i = 0; i < _test_size; ++i) {
        (*hset)[ikeys[i]] = i;
        q_temp = q_idx + _query_per_insert;
        for (; q_idx < q_temp; ++q_idx) {
            volatile auto qsink = hset->find(qkeys[q_idx]);
            (void)(qsink);
        }

        if (should_delete == _delete_every_niter) {
            volatile auto dsink = hset->erase(dkeys[d_idx++]);
            (void)(dsink);
            should_delete = 0;
        }
        ++should_delete;
    }

    timers::gettime(timers::ELAPSE, &end_ts);
    __atomic_fetch_add(&total_alloc_time, alloc_time, __ATOMIC_RELAXED);
    __atomic_fetch_add(&total_free_time, free_time, __ATOMIC_RELAXED);
    __atomic_fetch_add(&total_nsec,
                       timers::ts_to_ns(&end_ts) - timers::ts_to_ns(&start_ts),
                       __ATOMIC_RELAXED);
    

    return NULL;
}

int
main(int argc, char ** argv) {
    PREPARE_PARSER;
    ADD_ARG("-t", "--threads", false, Int, nthread, "Set nthreads");
    ADD_ARG("-n", false, Int, test_size, "Set n calls per thread");
    ADD_ARG("-d",
            "--delete-rate",
            false,
            Float,
            delete_rate,
            "Percent of operations to be deletes\n");
    ADD_ARG("-q",
            "--query-rate",
            false,
            Int,
            query_per_insert,
            "Percent of operations to be querys\n");
    ADD_ARG("--ds",
            "--delete-success",
            false,
            Float,
            delete_success,
            "Percent of deletes that succeed\n");
    ADD_ARG("--qs",
            "--query-success",
            false,
            Float,
            query_success,
            "Percent of querys that succeed\n");
    ADD_ARG("-i",
            "--insert-success",
            false,
            Float,
            insert_success,
            "Percent of inserts that are not duplicate\n");
    PARSE_ARGUMENTS;

    ERROR_ASSERT(!pthread_barrier_init(&b, NULL, nthread));


    uint32_t true_test_size =
        cmath::roundup<uint32_t>(test_size * nthread,
                                 CACHE_LINE_SIZE * nthread);
    ERROR_ASSERT(true_test_size);

    uint32_t true_n_queries =
        cmath::roundup<uint32_t>(test_size * nthread * query_per_insert,
                                 CACHE_LINE_SIZE * nthread);

    uint32_t true_n_deletes =
        cmath::roundup<uint32_t>(test_size * nthread * delete_rate,
                                 CACHE_LINE_SIZE * nthread);


    uint32_t insert_success_int_bound = insert_success * RAND_MAX;
    uint32_t query_success_int_bound  = query_success * RAND_MAX;
    uint32_t delete_success_int_bound = delete_success * RAND_MAX;


    uint64_t * insert_keys =
        (uint64_t *)calloc(true_test_size, sizeof(uint64_t));
    ERROR_ASSERT(insert_keys);

    uint64_t * query_keys =
        (uint64_t *)calloc(true_n_queries, sizeof(uint64_t));
    ERROR_ASSERT((!true_n_queries) || query_keys);


    uint64_t * delete_keys =
        (uint64_t *)calloc(true_n_deletes, sizeof(uint64_t));
    ERROR_ASSERT((!true_n_deletes) || delete_keys);

    uint32_t per_thread_tsize = true_test_size / nthread;
    uint32_t per_thread_qsize = true_n_queries / nthread;
    uint32_t per_thread_dsize = true_n_deletes / nthread;


    allocator_t allocator;
    my_allocator = &allocator;

    // init
    for (uint32_t i = 0; i < nthread; i++) {


        uint64_t * per_thread_ikeys = insert_keys + i * per_thread_tsize;
        uint64_t * per_thread_qkeys = query_keys + i * per_thread_qsize;
        uint64_t * per_thread_dkeys = delete_keys + i * per_thread_dsize;

        // initialize insert keys
        per_thread_ikeys[0] = rand() * rand() * rand();
        for (uint32_t j = 1; j < per_thread_tsize; j++) {
            if (insert_success_int_bound > (uint32_t)rand()) {
                per_thread_ikeys[j] = rand() * rand() * rand();
            }
            else {
                per_thread_ikeys[j] = insert_keys[rand() % j];
            }
        }

        if (query_keys) {
            // initialize query keys
            if (query_success_int_bound > (uint32_t)rand()) {
                per_thread_qkeys[0] = per_thread_ikeys[0];
            }
            else {
                per_thread_qkeys[0] = rand() * rand() * rand();
            }
            for (uint32_t j = 1; j < per_thread_qsize; j++) {
                if (insert_success_int_bound > (uint32_t)rand()) {

                    per_thread_qkeys[j] =
                        per_thread_ikeys[rand() % (j % per_thread_tsize)];
                }
                else {
                    per_thread_qkeys[j] = rand() * rand() * rand();
                }
            }
        }

        if (delete_keys) {
            // initialize delete keys (same as query keys)
            if (delete_success_int_bound > (uint32_t)rand()) {
                per_thread_dkeys[0] = per_thread_ikeys[0];
            }
            else {
                per_thread_dkeys[0] = rand() * rand() * rand();
            }
            for (uint32_t j = 1; j < per_thread_dsize; j++) {
                if (insert_success_int_bound > (uint32_t)rand()) {
                    per_thread_dkeys[j] =
                        per_thread_ikeys[rand() % (j % per_thread_tsize)];
                }
                else {
                    per_thread_dkeys[j] = rand() * rand() * rand();
                }
            }
        }
    }


    targs_t * targs = (targs_t *)calloc(nthread, sizeof(targs_t));
    for (uint32_t i = 0; i < nthread; i++) {
        targs[i].ikeys = insert_keys + i * per_thread_tsize;
        targs[i].qkeys = query_keys + i * per_thread_qsize;
        targs[i].dkeys = delete_keys + i * per_thread_dsize;
        targs[i].hset  = new pmap();
    }

    thelp::thelper th;
    th.spawn_n(nthread,
               test_hset,
               thelp::pin_policy::NONE,
               targs,
               sizeof(targs_t));
    th.join_all();

    uint32_t total_ops =
        (test_size + delete_rate * test_size + query_per_insert * test_size);
    fprintf(stderr,
            "[nthread = %d, calls per thread = %d]\n"
            "nanoseconds per operation  : %.2lf\n"
            "cycles per allocation      : %.2lf\n"
            "cycles per free            : %.2lf\n",
            nthread,
            total_ops,
            ((double)total_nsec) / (total_ops * nthread),
            ((double)total_alloc_time) / (total_ops * nthread),
            ((double)total_free_time) / (total_ops * nthread));


    free(targs);
    free(insert_keys);
    if (query_keys) {
        free(query_keys);
    }
    if (delete_keys) {
        free(delete_keys);
    }

    for (uint32_t i = 0; i < msize; i++) {
        if (bucket_list[i]) {
            fprintf(stderr, "%d: %d\n", i, bucket_list[i]);
        }
    }
}
