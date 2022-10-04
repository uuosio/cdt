configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cdt-init.cpp ${CMAKE_BINARY_DIR}/cdt-init.cpp @ONLY)

add_tool(cdt-init)

if (NOT WIN32)
    set_target_properties(cdt-init PROPERTIES LINK_FLAGS "-Wl,-rpath,\"\\$ORIGIN/../lib\"")
endif()
