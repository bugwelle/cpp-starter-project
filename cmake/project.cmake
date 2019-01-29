function(activate_cotire)
  if(ENABLE_COTIRE)
    include(cotire) # Used for precompiled headers and other optimizations
    return()
  endif()
  message(STATUS "Cotire manually disabled")
endfunction()
