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

# Utility rule file for run_gen_sys_header.

# Include the progress variables for this target.
include CMakeFiles/run_gen_sys_header.dir/progress.make

CMakeFiles/run_gen_sys_header:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/noah/programs/new_obj_allocation/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating PRECOMPUTED_SYS_INFO.h"
	cd /home/noah/programs/new_obj_allocation && /home/noah/programs/new_obj_allocation/build/gen_sys_header

run_gen_sys_header: CMakeFiles/run_gen_sys_header
run_gen_sys_header: CMakeFiles/run_gen_sys_header.dir/build.make

.PHONY : run_gen_sys_header

# Rule to build all files generated by this target.
CMakeFiles/run_gen_sys_header.dir/build: run_gen_sys_header

.PHONY : CMakeFiles/run_gen_sys_header.dir/build

CMakeFiles/run_gen_sys_header.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/run_gen_sys_header.dir/cmake_clean.cmake
.PHONY : CMakeFiles/run_gen_sys_header.dir/clean

CMakeFiles/run_gen_sys_header.dir/depend:
	cd /home/noah/programs/new_obj_allocation/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/noah/programs/new_obj_allocation /home/noah/programs/new_obj_allocation /home/noah/programs/new_obj_allocation/build /home/noah/programs/new_obj_allocation/build /home/noah/programs/new_obj_allocation/build/CMakeFiles/run_gen_sys_header.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/run_gen_sys_header.dir/depend

