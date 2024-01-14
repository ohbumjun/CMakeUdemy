set(APP_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/main.cc")

# set(EXE_HEADERS
#    "main.h")

# create target , executable \\ make to exe
add_executable(${EXECUTABLE_NAME} ${APP_SOURCES})

# added library should be linked to exeutable
# ex) when file in executable use function in library, executable should be linked to library
# exectable depends on library. when build executable, library should be built first
target_link_libraries(
    ${EXECUTABLE_NAME}
    PRIVATE ${LIBRARY_NAME}
            nlohmann_json::nlohmann_json
            fmt::fmt
            spdlog::spdlog
            cxxopts::cxxopts)

if(${ENABLE_WARNINGS})
    target_set_warnings(
        TARGET # parameter name
        ${EXECUTABLE_NAME} # argument for above parameter
        ENABLE
        ${ENABLE_WARNINGS}
        #${ENABLE_WARNINGS} # if used 'multiValueArgs', multiple argument pass available
        AS_ERRORS
        ${ENABLE_WARNINGS_AS_ERRORS})
endif()

if(${ENABLE_LTO})
    target_enable_lto(
        TARGET
        ${EXECUTABLE_NAME}
        ENABLE
        ON)
endif()

if(${ENABLE_CLANG_TIDY})
    add_clang_tidy_to_target(${EXECUTABLE_NAME})
endif()
