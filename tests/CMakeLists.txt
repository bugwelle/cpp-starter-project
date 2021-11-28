# -----------------------------------------------------------------------------
# Tests

# I use FetchContent here because Catch2 is a small dependency, that is only
# used for testing.  You could also use: find_package(Catch2 REQUIRED)
fetchcontent_declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG v2.13.1
)
fetchcontent_makeavailable(Catch2)

add_executable(cpp_test)
target_include_directories(cpp_test PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(cpp_test PRIVATE Catch2::Catch2 cpp_starter_math)

target_sources(
  cpp_test
  PRIVATE main.cpp
          math/test_fibonacci.cpp # List all test sources here. Prefix your test
                                  # sources with `test_` to avoid name clashes
                                  # with files in `src`.
)

# If ENABLE_COVERAGE is set, generate a coverage report for this test.
generate_coverage_report(cpp_test)

# Let Catch2 find all tests so that CTest can list all tests instead of just one
# executable.
catch_discover_tests(cpp_test)

set_post_target_defaults(cpp_test)
