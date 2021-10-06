# Set the default build type if not set by the user.
function(set_default_build_type buildType)
  if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(
      STATUS "Setting build type to '${buildType}' as none was specified."
    )
    set(CMAKE_BUILD_TYPE
        "${buildType}"
        CACHE STRING "Choose the type of build." FORCE
    )
    # Set the possible values of build type for cmake-gui
    set_property(
      CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel"
                                      "RelWithDebInfo"
    )
  endif()
endfunction()

function(check_no_in_source_build)
  if(CMAKE_BINARY_DIR STREQUAL CMAKE_SOURCE_DIR)
    message(
      WARNING
        "Building in-source is not recommended! Create a build dir and remove ${CMAKE_SOURCE_DIR}/CMakeCache.txt"
    )
  endif()
endfunction()
