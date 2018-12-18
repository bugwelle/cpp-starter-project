# CMake >= 3.12 has some new features like `HOMEPAGE_URL`. It also supports
# C++20 using `cxx_std_20` in `target_compile_features`.
cmake_minimum_required(VERSION 3.12 FATAL_ERROR)

project(
  cpp_starter
  VERSION
    0.1.0
    DESCRIPTION
    "C++ Starter Project"
    HOMEPAGE_URL
    "https://gitlab.com/bugwelle/cpp-starter-project"
  LANGUAGES CXX
)

message("=> Project: ${PROJECT_NAME}")

# -----------------------------------------------------------------------------
# CMake modules and other cmake related (third-party) scripts
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

find_package(Sanitizers) # For Thread/Address/Memory/UB Sanitizers
find_package(Shellcheck)
find_package(CMakeFormat)
find_package(CppCheck)
find_package(gcov)
find_package(lcov)

include(GenerateExportHeader) # TODO: WHY?
include(WriteCompilerDetectionHeader) # TODO: Variable RESULT_VARIABLE; Why?
include(cotire) # Used for precompiled headers and other optimizations
include(warnings) # Custom function that enables compiler warnings
include(GetGitRevisionDescription)
include(coverage) # For lcov and gcov code coverage

# Package Manager includes
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup(TARGETS)

# -----------------------------------------------------------------------------
# Get git revision
get_git_head_revision(GIT_REFSPEC GIT_SHA1)
string(SUBSTRING "${GIT_SHA1}" 0 12 GIT_REV)
if(NOT GIT_SHA1)
  set(GIT_REV "0")
endif()

# -----------------------------------------------------------------------------
# Project configuration options. Sanitizer options are defined in the
# correspondig FindXX modules.
# cmake-format: off
option(OPTION_CLANG_TIDY       "Analyze code with clang-tidy."                OFF)
option(OPTION_CLANG_TIDY_FIX   "Analyze code with clang-tidy and fix errors." OFF)
option(OPTION_ENABLE_COVERAGE  "Add coverage information."                    OFF)
# cmake-format: on

if(OPTION_CLANG_TIDY)
  message(STATUS "clang-tidy enabled")
  set(CMAKE_CXX_CLANG_TIDY clang-tidy -format-style=file)

elseif(OPTION_CLANG_TIDY_FIX)
  message(STATUS "clang-tidy with auto-fix enabled")
  set(CMAKE_CXX_CLANG_TIDY clang-tidy -format-style=file -fix)

endif()

enable_coverage(OPTION_ENABLE_COVERAGE)

# -----------------------------------------------------------------------------
# Some defaults for our targets. Currently warnings are enabled and the C++
# standard is set to C++17. It simlifies handling multiple targets like
# different libraries without having to repeat all compile-features, etc.
function(set_target_defaults target)
  if(NOT TARGET ${target})
    message(WARNING "cpp-starter defaults: ${target} is not a target.")
    return()
  endif()
  target_compile_features(${target} PUBLIC cxx_std_17)
  # We want a better project structure in some IDEs like Visual Studio. See
  # https://cmake.org/cmake/help/latest/prop_tgt/FOLDER.html
  set_target_properties(${target} PROPERTIES FOLDER "${PROJECT_NAME}")
  target_include_directories(
    ${target}
    PUBLIC ${CMAKE_BINARY_DIR} ${CMAKE_SOURCE_DIR}/src
  )
  enable_warnings(${target})
  target_enable_coverage(${target})
endfunction()

# -----------------------------------------------------------------------------
add_subdirectory(docs)
add_subdirectory(external) # third-party targets (e.g. interface targets for
                           # header-only libraries)
add_subdirectory(src)
add_subdirectory(tools) # Tools like cppcheck and cmake-format

include(CTest)
enable_testing()
add_subdirectory(tests)
