# -----------------------------------------------------------------------------
# Modules
add_subdirectory(math)

# -----------------------------------------------------------------------------
# Main cpp_starter executable
add_executable(cpp_starter)
target_link_libraries(cpp_starter PRIVATE cpp_starter_math)
target_link_libraries(cpp_starter PRIVATE CONAN_PKG::range-v3 clara)

configure_file(version.hpp.in ${PROJECT_BINARY_DIR}/version.hpp @ONLY)

# -----------------------------------------------------------------------------
# Installation
install(TARGETS cpp_starter RUNTIME DESTINATION bin)

# -----------------------------------------------------------------------------
# Sources
target_sources(cpp_starter PRIVATE main.cpp)

# -----------------------------------------------------------------------------
# Defaults
set_post_target_defaults(cpp_starter)
