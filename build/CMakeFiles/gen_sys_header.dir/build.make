# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/noah/local_cmake/cmake-3.15.2/bin/cmake

# The command to remove a file.
RM = /home/noah/local_cmake/cmake-3.15.2/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/noah/programs/new_obj_allocation

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/noah/programs/new_obj_allocation/build

# Include any dependencies generated for this target.
include CMakeFiles/gen_sys_header.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/gen_sys_header.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/gen_sys_header.dir/flags.make

CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.o: CMakeFiles/gen_sys_header.dir/flags.make
CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.o: ../src/gen_system_header.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/noah/programs/new_obj_allocation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.o -c /home/noah/programs/new_obj_allocation/src/gen_system_header.cc

CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/noah/programs/new_obj_allocation/src/gen_system_header.cc > CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.i

CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/noah/programs/new_obj_allocation/src/gen_system_header.cc -o CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.s

CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.o: CMakeFiles/gen_sys_header.dir/flags.make
CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.o: ../lib/timing/stats.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/noah/programs/new_obj_allocation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.o -c /home/noah/programs/new_obj_allocation/lib/timing/stats.cc

CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/noah/programs/new_obj_allocation/lib/timing/stats.cc > CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.i

CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/noah/programs/new_obj_allocation/lib/timing/stats.cc -o CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.s

CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.o: CMakeFiles/gen_sys_header.dir/flags.make
CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.o: ../lib/timing/thread_helper.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/noah/programs/new_obj_allocation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.o -c /home/noah/programs/new_obj_allocation/lib/timing/thread_helper.cc

CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/noah/programs/new_obj_allocation/lib/timing/thread_helper.cc > CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.i

CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/noah/programs/new_obj_allocation/lib/timing/thread_helper.cc -o CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.s

CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.o: CMakeFiles/gen_sys_header.dir/flags.make
CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.o: ../lib/util/arg.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/noah/programs/new_obj_allocation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.o -c /home/noah/programs/new_obj_allocation/lib/util/arg.cc

CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/noah/programs/new_obj_allocation/lib/util/arg.cc > CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.i

CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/noah/programs/new_obj_allocation/lib/util/arg.cc -o CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.s

# Object files for target gen_sys_header
gen_sys_header_OBJECTS = \
"CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.o" \
"CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.o" \
"CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.o" \
"CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.o"

# External object files for target gen_sys_header
gen_sys_header_EXTERNAL_OBJECTS =

gen_sys_header: CMakeFiles/gen_sys_header.dir/src/gen_system_header.cc.o
gen_sys_header: CMakeFiles/gen_sys_header.dir/lib/timing/stats.cc.o
gen_sys_header: CMakeFiles/gen_sys_header.dir/lib/timing/thread_helper.cc.o
gen_sys_header: CMakeFiles/gen_sys_header.dir/lib/util/arg.cc.o
gen_sys_header: CMakeFiles/gen_sys_header.dir/build.make
gen_sys_header: CMakeFiles/gen_sys_header.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/noah/programs/new_obj_allocation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable gen_sys_header"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gen_sys_header.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/gen_sys_header.dir/build: gen_sys_header

.PHONY : CMakeFiles/gen_sys_header.dir/build

CMakeFiles/gen_sys_header.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/gen_sys_header.dir/cmake_clean.cmake
.PHONY : CMakeFiles/gen_sys_header.dir/clean

CMakeFiles/gen_sys_header.dir/depend:
	cd /home/noah/programs/new_obj_allocation/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/noah/programs/new_obj_allocation /home/noah/programs/new_obj_allocation /home/noah/programs/new_obj_allocation/build /home/noah/programs/new_obj_allocation/build /home/noah/programs/new_obj_allocation/build/CMakeFiles/gen_sys_header.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/gen_sys_header.dir/depend
