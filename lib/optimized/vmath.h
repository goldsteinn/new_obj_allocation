#ifndef _VMATH_H_
#define _VMATH_H_

#include <misc/cpp_attributes.h>
#include <optimized/division.h>
#include <optimized/multiply.h>

#include <immintrin.h>


namespace vmath {

template<typename T, T denum>
constexpr __m256i ALWAYS_INLINE CONST_ATTR
vdiv(__m256i n) {
    return do_div_vector<T, denum>(n);
}

template<typename T, T denum>
constexpr __m256i ALWAYS_INLINE
vdiv_T(T * n) {
    return vdiv<T, denum>(_mm256_load_si256((__m256i *)n));
}

template<typename T, T denum>
constexpr void ALWAYS_INLINE
vdiv_inplace(T * n) {
    _mm256_store_si256((__m256i *)n, vdiv_T<T, denum>(n));
}

template<typename T, T mult>
constexpr __m256i ALWAYS_INLINE CONST_ATTR
vmult(__m256i n) {
    return do_mult_vector<T, mult>(n);
}

template<typename T, T mult>
constexpr __m256i ALWAYS_INLINE
vmult_T(T * n) {
    return vmult<T, mult>(_mm256_load_si256((__m256i *)n));
}

template<typename T, T mult>
constexpr void ALWAYS_INLINE
vmult_inplace(T * n) {
    _mm256_store_si256((__m256i *)n, vmult_T<T, mult>(n));
}

template<typename T>
constexpr __m256i ALWAYS_INLINE CONST_ATTR
vsub(__m256i l, __m256i r) {
    if constexpr (sizeof(T) == sizeof(uint64_t)) {
        return _mm256_sub_epi64(l, r);
    }
    else {
        return _mm256_sub_epi32(l, r);
    }
}

template<typename T>
constexpr __m256i ALWAYS_INLINE CONST_ATTR
vsub_c(__m256i l, T r) {
    return vsub<T>(l, _mm256_set1_epi64x(r));
}

template<typename T>
constexpr __m256i ALWAYS_INLINE
vsub_T(T * l, T r) {
    return vsub_c<T>(_mm256_load_si256((__m256i *)l), r);
}

template<typename T>
constexpr void ALWAYS_INLINE
vsub_inplace(T * l, T r) {
    _mm256_store_si256((__m256i *)l, vsub_T<T>(l, r));
}

template<typename T>
constexpr void ALWAYS_INLINE
vsub_inplace_v(T * l, __m256i r) {
    _mm256_store_si256((__m256i *)l,
                       vsub<T>(_mm256_load_si256((__m256i *)l), r));
}


template<typename T>
constexpr __m256i ALWAYS_INLINE CONST_ATTR
vadd(__m256i l, __m256i r) {
    if constexpr (sizeof(T) == sizeof(uint64_t)) {
        return _mm256_add_epi64(l, r);
    }
    else {
        return _mm256_add_epi32(l, r);
    }
}

template<typename T>
constexpr __m256i ALWAYS_INLINE CONST_ATTR
vadd_c(__m256i l, T r) {
    return vadd<T>(l, _mm256_set1_epi64x(r));
}

template<typename T>
constexpr __m256i ALWAYS_INLINE
vadd_T(T * l, T r) {
    return vadd_c<T>(_mm256_load_si256((__m256i *)l), r);
}

template<typename T>
constexpr void ALWAYS_INLINE
vadd_inplace(T * l, T r) {
    _mm256_store_si256((__m256i *)l, vadd_T<T>(l, r));
}


}  // namespace vmath

#endif