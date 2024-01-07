
# call from executables
# ex) refer to app/CmakeLists.txt
function(target_set_warnings TARGET ENABLED ENABLED_AS_ERRORS)
    if (NOT ${ENABLED})
        message(STATUS "Warnings disabled for ${TARGET}")
        return()
    endif()

    # set 3 variables
    # MSVC compiler options
    # ex) window based 
    set(MSVC_COMPILER 
        /W4 
        /permissive) # use small subset of warnings

    # Clang compiler options
    set(CLANG_COMPILER 
        -Wall 
        -Wextra 
        -Wpedantic)
        
    # GCC compiler options
    set(GCC_WARNINGS 
        ${CLANG_WARNINGS})

   
    if(${ENABLED_AS_ERRORS})
        set(MSVC_WARNINGS ${MSVC_WARNINGS} /WX)
        set(CLANG_WARNINGS ${CLANG_WARNINGS} -Werror)
        set(GCC_WARNINGS ${GCC_WARNINGS} -Werror)
    endif()

    #check which compiler is used by user
    if (CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(WARNINGS ${MSVC_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set(WARNINGS ${CLANG_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set(WARNINGS ${GCC_WARNINGS})
    endif()

    # function used whenever you want to pass in compiler flags for certain target
    target_compile_options(${TARGET} PRIVATE ${WARNINGS})

    message(STATUS ${WARNINGS})
    
endfunction()