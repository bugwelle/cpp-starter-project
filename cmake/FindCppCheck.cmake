find_program(CPPCHECK_EXE NAMES cppcheck DOC "static code analysis tool")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CppCheck DEFAULT_MSG CPPCHECK_EXE)

mark_as_advanced(CPPCHECK_EXE)
