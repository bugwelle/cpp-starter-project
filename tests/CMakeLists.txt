# -----------------------------------------------------------------------------
# Tests

add_executable(cpp_test)
target_include_directories(cpp_test PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(cpp_test PRIVATE CONAN_PKG::Catch2 cpp_starter_math)

target_sources(
  cpp_test
  PRIVATE
  main.cpp
  math/test_fibonacci.cpp # List all test sources here. Prefix your test sources
                          # with `test_` to avoid name clashes with files in
                          # `src`.
)

# Cotire would use a PCH for Catch2 which results in `CATCH_CONFIG_RUNNER` not
# having any effect.
set_source_files_properties(main.cpp PROPERTIES COTIRE_EXCLUDED ON)

# If ENABLE_COVERAGE is set, generate a coverage report for this test.
generate_coverage_report(cpp_test)

# Let Catch2 find all tests so that CTest can list all tests instead of just one
# executable.
catch_discover_tests(cpp_test)

set_post_target_defaults(cpp_test)
