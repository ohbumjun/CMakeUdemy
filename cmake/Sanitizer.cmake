function(add_sanitizer_flags)
    # non of flags active 
    if (NOT ENABLE_SANITIZE_ADDR AND NOT ENABLE_SANITIZE_UNDEF)
        message(STATUS "Sanitizers deactivated.")
        return()
    endif()

    # options to use saniteizer differs based on compiler 
    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        # add compile option to all target (all executables and libraries)
        # (refer) target_compile_options : add compile option to specific target
        add_compile_options("-fno-omit-frame-pointer")
        add_link_options("-fno-omit-frame-pointer")

        if(ENABLE_SANITIZE_ADDR)
            add_compile_options("-fsanitize=address")
            add_link_options("-fsanitize=address")
        endif()

        if(ENABLE_SANITIZE_UNDEF)
            add_compile_options("-fsanitize=undefined")
            add_link_options("-fsanitize=undefined")
        endif()
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        if(ENABLE_SANITIZE_ADDR)
            add_compile_options("/fsanitize=address")
        endif()

        if(ENABLE_SANITIZE_UNDEF)
            message(STATUS "Undefined sanitizer not impl. for MSVC!")
        endif()
    else()
        message(STATUS "Sanitizer not supported in this environment!")
    endif()
endfunction(add_sanitizer_flags)