cmake_minimum_required(VERSION 3.16 FATAL_ERROR)

project(
  cpp_starter
  VERSION 0.2.0
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
# cmake-format: on

# -----------------------------------------------------------------------------
# CMake modules and other cmake related (third-party) scripts
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

include(MiscFunctions)
check_no_in_source_build()
set_default_build_type("RelWithDebInfo")

# for Thread/Address/Memory/UB Sanitizers
find_package(Sanitizers)

include(GNUInstallDirs)
include(FetchContent)
include(GenerateExportHeader) # TODO: WHY?
include(warnings) # custom function that enables compiler warnings
include(GetGitRevisionDescription)
include(coverage) # for lcov and gcov code coverage
include(clang-tidy)

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

# -----------------------------------------------------------------------------
# Packaging

include(InstallRequiredSystemLibraries)

# See https://cmake.org/cmake/help/latest/module/CPack.html#variables-common-to-all-cpack-generators
set(CPACK_PACKAGE_VENDOR "bugwelle")
set(CPACK_PACKAGE_CHECKSUM "SHA512")
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_LIST_DIR}/packaging/description.txt")
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_LIST_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_LIST_DIR}/README.md")
set(CPACK_PACKAGE_EXECUTABLES "cpp_starter;C++ Starter")
set(CPACK_VERBATIM_VARIABLES True)
set(CPACK_THREADS 0)

# Specific to macOS
set(CPACK_BUNDLE_NAME "C++ Starter")

include(CPack)
