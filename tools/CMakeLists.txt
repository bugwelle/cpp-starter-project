find_package(CppCheck)
find_package(Shellcheck)
find_package(CMakeFormat)

# -----------------------------------------------------------------------------
# cppcheck
if(CppCheck_FOUND)
  # We take advantage of our project structure and that all include paths are
  # relative to `src`. I dislike using CXX_CPPCHECK as it runs next to the
  # compiler but doesn't require compiling the source code if run as a separate
  # process. Distinguishing between compiler and cppcheck warnings may be
  # bothering but not neccessarily a bad practice. If we were to introduce a
  # more complex project structure with different include paths, it may be
  # preferable to use CXX_CPPCHECK.
  add_custom_target(
    cppcheck
    COMMAND ${CPPCHECK_EXE} -j2 --enable=all -I${CMAKE_SOURCE_DIR}/src -j1
            ${CMAKE_SOURCE_DIR}/src
    COMMENT "format cmake files"
  )
endif()

# -----------------------------------------------------------------------------
# Bash script linting using shellcheck
if(Shellcheck_FOUND)
  add_custom_target(
    shellcheck
    COMMAND ${SHELLCHECK_EXE} "${CMAKE_SOURCE_DIR}/tools/*.sh"
    COMMENT "Lint bash scripts using shellcheck"
  )
endif()

# -----------------------------------------------------------------------------
# cmake-format
if(CMakeFormat_FOUND)
  add_custom_target(
    cmake-format
    COMMAND
      ${CMAKE_FORMAT_EXE} -c ${CMAKE_SOURCE_DIR}/.cmake-format -i
      ${CMAKE_SOURCE_DIR}/CMakeLists.txt ${CMAKE_SOURCE_DIR}/docs/CMakeLists.txt
      ${CMAKE_SOURCE_DIR}/src/CMakeLists.txt
      ${CMAKE_SOURCE_DIR}/tests/CMakeLists.txt ${CMAKE_SOURCE_DIR}/cmake/*.cmake
      ${CMAKE_SOURCE_DIR}/tools/CMakeLists.txt
    COMMENT "format cmake files"
  )
endif()
