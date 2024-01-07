set(EXE_SOURCES
    "main.cc")

# set(EXE_HEADERS
#    "main.h")


# create target , executable \\ make to exe
add_executable(${EXECUTABLE_NAME} ${EXE_SOURCES})

# added library should be linked to exeutable
# ex) when file in executable use function in library, executable should be linked to library
# exectable depends on library. when build executable, library should be built first
target_link_libraries(${EXECUTABLE_NAME} PUBLIC 
${LIBRARY_NAME}
nlohmann_json
)

if (ENABLE_WARNINGS)
    target_set_warnings(
        ${EXECUTABLE_NAME}
        ON
        OFF
    )
endif()

if (ENABLE_LTO)
    target_enable_lto(
        ${EXECUTABLE_NAME}
        ${ENABLE_LTO}
    )
endif()