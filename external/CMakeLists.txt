# -----------------------------------------------------------------------------
# Some interface targets for third-party dependencies
add_library(clara INTERFACE)
# "SYSTEM" so we don't get compiler warnings for it
target_include_directories(clara SYSTEM INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
