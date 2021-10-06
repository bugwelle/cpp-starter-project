# CMake >= 3.12 has some new features like `HOMEPAGE_URL`. It also supports
# C++20 using `cxx_std_20` in `target_compile_features`.
cmake_minimum_required(VERSION 3.12 FATAL_ERROR)

project(
  cpp_starter
  VERSION 0.1.0
  DESCRIPTION "C++ Starter Project"
  HOMEPAGE_URL "https://github.com/bugwelle/cpp-starter-project"
  LANGUAGES CXX
)

message("=> Project: ${PROJECT_NAME}")

# -----------------------------------------------------------------------------
# Project configuration options. Sanitizer options are defined in the
# correspondig FindXX modules.
# cmake-format: off
option(ENABLE_CLANG_TIDY       "Analyze code with clang-tidy."                OFF)
option(ENABLE_CLANG_TIDY_FIX   "Analyze code with clang-tidy and fix errors." OFF)
option(ENABLE_COVERAGE         "Add coverage information to binaries."        OFF)
option(ENABLE_COTIRE           "Disable cotire."                              OFF)
# cmake-format: on

# -----------------------------------------------------------------------------
# CMake modules and other cmake related (third-party) scripts
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

include(MiscFunctions)
check_no_in_source_build()
# conan requires that CMAKE_BUILD_TYPE is set.  If none is set, use this
# default.
set_default_build_type("RelWithDebInfo")

# for Thread/Address/Memory/UB Sanitizers
find_package(Sanitizers)

if(ENABLE_COTIRE)
  include(cotire) # Used for precompiled headers and other optimizations
endif()
include(GenerateExportHeader) # TODO: WHY?
include(warnings) # custom function that enables compiler warnings
include(GetGitRevisionDescription)
include(coverage) # for lcov and gcov code coverage
include(clang-tidy)

# Package Manager includes
include(conan)

conan_cmake_run(
  CONANFILE
  conanfile.txt
  BASIC_SETUP # Conan Basic Setup
  NO_OUTPUT_DIRS # Don't mess with CMake's default build structure
  PROFILE_AUTO # Use CMake Compiler settings
  CMAKE_TARGETS # Use CMake targets
  BUILD
  missing
)

# -----------------------------------------------------------------------------
# Get git revision
get_git_head_revision(GIT_REFSPEC GIT_SHA1)
string(SUBSTRING "${GIT_SHA1}" 0 12 GIT_REV)
if(NOT GIT_SHA1)
  set(GIT_REV "0")
endif()

activate_coverage(ENABLE_COVERAGE)

# -----------------------------------------------------------------------------
# Some defaults for our targets. Currently warnings are enabled and the C++
# standard is set to C++20. It simplifies handling multiple targets like
# different libraries without having to repeat all compile-features, etc. Call
# this function after *all* targets have been added to ${target}!
#
# TODO: Can we now use a target and link against it instead?
function(set_post_target_defaults target)
  if(NOT TARGET ${target})
    message(WARNING "cpp-starter defaults: ${target} is not a target.")
    return()
  endif()
  target_compile_features(${target} PUBLIC cxx_std_20)
  # We want a better project structure in some IDEs like Visual Studio. See
  # https://cmake.org/cmake/help/latest/prop_tgt/FOLDER.html
  set_target_properties(${target} PROPERTIES FOLDER "${PROJECT_NAME}")
  target_include_directories(
    ${target} PUBLIC ${CMAKE_BINARY_DIR} ${CMAKE_SOURCE_DIR}/src
  )
  enable_warnings(${target})
  target_enable_coverage(${target})
  add_sanitizers(${target})
  if(ENABLE_COTIRE)
    cotire(${target})
  endif()
endfunction()

# -----------------------------------------------------------------------------
add_subdirectory(docs)
add_subdirectory(external) # third-party targets (e.g. interface targets for
                           # header-only libraries)
add_subdirectory(src)
add_subdirectory(tools) # Tools like cppcheck and cmake-format

# -----------------------------------------------------------------------------
# Tests using Catch2 and CTest
include(CTest)
include(Catch)
enable_testing() # Per CMake documentation, enable_testing() must be called in
                 # the root directory.
add_subdirectory(tests)
