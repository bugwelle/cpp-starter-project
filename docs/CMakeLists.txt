# ------------------------------------------------------------------------------
# Doxygen
find_package(Doxygen OPTIONAL_COMPONENTS dot)
if(DOXYGEN_FOUND)
  set(DOXYGEN_PROJECT_BRIEF "${PROJECT_NAME}")
  set(DOXYGEN_GENERATE_TREEVIEW YES)
  set(DOXYGEN_USE_MDFILE_AS_MAINPAGE ../README.md)

  doxygen_add_docs(
    doxygen ../README.md ../src COMMENT "Generate doxygen documentation"
  )
endif()

# ------------------------------------------------------------------------------
# Sphinx User Documentation
find_package(Sphinx)
if(SPHINX_FOUND)
  add_custom_target(
    docs
    COMMAND
      ${SPHINX_EXECUTABLE} -M html "${CMAKE_CURRENT_SOURCE_DIR}/user/source"
      "${CMAKE_CURRENT_BINARY_DIR}/user"
    COMMENT "Build HTML documentation with Sphinx"
  )
endif()
