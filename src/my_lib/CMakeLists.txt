set(LIBRARY_SOURCES "my_lib.cc")

set(LIBRARY_HEADERS "my_lib.h")

set(LIBRARY_INCLUDES
    "./"
    # also include files from other directories
    "${CMAKE_BINARY_DIR}/configured_files/include")

# create target, but not executable == library
# STATIC : staic library    ex) .lib
# SHARED : dynamic library  ex) .dll
add_library(${LIBRARY_NAME} STATIC ${LIBRARY_SOURCES} ${LIBRARY_HEADERS})

# where to find header files
# cpp file can include header files from "./~~"
target_include_directories(${LIBRARY_NAME} PUBLIC ${LIBRARY_INCLUDES})

# link library to own library
target_link_libraries(
    ${LIBRARY_NAME}
    PUBLIC # other libraries
           # ex) projectname::libraryname (refer to other github cmakelists.txt)
           cxxopts::cxxopts
           nlohmann_json::nlohmann_json
           fmt::fmt
           spdlog::spdlog)

if(${ENABLE_WARNINGS})
    target_set_warnings(
        TARGET
        ${LIBRARY_NAME}
        ENABLE
        ${ENABLE_WARNINGS}
        AS_ERRORS
        ${ENABLE_WARNINGS_AS_ERRORS})
endif()

if(${ENABLE_LTO})
    target_enable_lto(
        TARGET
        ${LIBRARY_NAME}
        ENABLE
        ON)
endif()

# apply clang-tidy
if(${ENABLE_CLANG_TIDY})
    add_clang_tidy_to_target(${LIBRARY_NAME})
endif()
