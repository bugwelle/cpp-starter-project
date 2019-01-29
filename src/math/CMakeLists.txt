add_library(cpp_starter_math STATIC)
set_target_defaults(cpp_starter_math)

target_sources(cpp_starter_math PRIVATE "fibonacci.cpp")
use_cotire(cpp_starter_math)
