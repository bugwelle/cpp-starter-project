add_library(cpp_starter_math STATIC)

target_sources(cpp_starter_math PRIVATE "fibonacci.cpp")

set_post_target_defaults(cpp_starter_math)
