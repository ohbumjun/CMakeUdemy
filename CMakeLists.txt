# 0. create source and cmakefile
# 1. create build folder
# 2. cd build
# 3. cmake .. (Generating the build files / configure the project)
# 4. cmake --build . (Compile the project, make final exe file)
# 5. ./Executable

cmake_minimum_required(VERSION 3.22)

# set the project name
project(
    CPPProjectCMake
    VERSION 1.0.0
    LANGUAGES C CXX)

# every target in our project set to use C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED On)

# ex) some c variable not in C++ standard. but can be used in gcc
#     disable these kinds of examples
set(CMAKE_CXX_EXTENSIONS OFF)

# generate 'compile_commands.json' file so that clang-tidy can know
# which files to look for
# ex) clang-tidy is a tool that runs before compilation
#     so it has to know where to look for all files of project
#     based on compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# can pass variable to set 'COMPILE_EXECUTABLE' value in command line
# ex) cmake .. -DCOMPILE_EXECUTABLE=ON
option(COMPILE_EXECUTABLE "Whether to compile the executable" ON)
# compiler warning not off !
option(ENABLE_WARNINGS "Enable to add warnings to a target." ON
)# always should be on
# if single one warning occurs, compilation will fail
option(ENABLE_WARNINGS_AS_ERRORS "Enable to treat warnings as errors." OFF)

# sanitizer : runtime tool that helps to find memory corruption, memory leak etc.
option(ENABLE_SANITIZE_ADDR "Enable address sanitizer" ON)
option(ENABLE_SANITIZE_UNDEF "Enable undefined sanitizer" ON)

option(ENABLE_LTO "Enable LTO/IPO" ON)

option(ENABLE_CLANG_TIDY "Enable to add clang tidy." ON)

option(USE_CPM "Whether to use CPM" ON)
option(USE_CONAN "Whether to use CONAN" OFF)
option(USE_VCPKG "Whether to use VcPkg" OFF)

option(ENABLE_CLANG_FORMAT "Enable to add clang-format." ON)
option(ENABLE_CMAKE_FORMAT "Enable to add cmake-format." ON)

# define variable. all used in subdirectories cmakefiles
set(LIBRARY_NAME "Library")
set(EXECUTABLE_NAME "Executable")
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

# include cmake module files
# reference : already predefined cmake modules exist in my cmake version
include(ConfigSafeGuards)
include(AddGitSubmodule)
include(Docs)
include(Tools)
if(ENABLE_WARNINGS)
    include(Warnings)
endif()

if(ENABLE_LTO)
    include(LTO)
endif()

if(ENABLE_SANITIZE_ADDR OR ENABLE_SANITIZE_UNDEF)
    include(Sanitizer)
    add_sanitizer_flags()
endif()

# clang format, cmake format
add_cmake_format_target()
add_clang_format_target()

# build in cmake modules
include(FetchContent)

if(USE_CPM)
    message(STATUS "Using CPM")
    include(CPM)
    cpmaddpackage("gh:nlohmann/json#v3.11.2")
    cpmaddpackage("gh:fmtlib/fmt#8.0.1")
    cpmaddpackage("gh:gabime/spdlog#v1.9.2")
    cpmaddpackage("gh:jarro2783/cxxopts#v3.1.1")
    cpmaddpackage("gh:catchorg/Catch2#v2.13.9")
elseif(USE_CONAN)
    message(STATUS "Using Conan")
    # generated path by command
    include(${CMAKE_BINARY_DIR}/conan_toolchain.cmake)
    find_package(nlohmann_json REQUIRED)
    find_package(fmt REQUIRED)
    find_package(fmtd REQUIRED)
    find_package(spdlog REQUIRED)
    find_package(cxxopts REQUIRED)
    find_package(Catch2 REQUIRED)
elseif(USE_VCPKG)
    message(STATUS "Using VCPKG")
    include(${CMAKE_SOURCE_DIR}/external/vcpkg/scripts/buildsystems/vcpkg.cmake)
    find_package(nlohmann_json REQUIRED)
    find_package(fmt REQUIRED)
    find_package(spdlog REQUIRED)
    find_package(cxxopts REQUIRED)
    find_package(Catch2 REQUIRED)
else()
    message(STATUS "Using FetchContent")
    # main idea
    # - declare which github repository to use -> be cloned to build directory
    # - GIT_REPOSITORY needs to be cmake project
    FetchContent_Declare(
        # defined in other github repo cmakelist.txt as project name
        # ex) project(CPPProjectCMake VERSION 1.0.0 LANGUAGES C CXX)
        nlohmann_json
        GIT_REPOSITORY https://github.com/nlohmann/json.git
        # which version
        GIT_TAG v3.11.2
        # would not clone recursively
        GIT_SHALLOW TRUE)

    FetchContent_Declare(
        FMT
        GIT_REPOSITORY https://github.com/fmtlib/fmt.git
        GIT_TAG v8.0.1
        GIT_SHALLOW TRUE)

    FetchContent_Declare(
        cxxopts
        GIT_REPOSITORY https://github.com/jarro2783/cxxopts.git
        GIT_TAG v3.1.1
        GIT_SHALLOW TRUE)

    FetchContent_Declare(
        Catch2
        GIT_REPOSITORY https://github.com/catchorg/Catch2
        GIT_TAG v2.13.9
        GIT_SHALLOW TRUE)

    FetchContent_Declare(
        spdlog
        GIT_REPOSITORY https://github.com/gabime/spdlog
        GIT_TAG v1.9.2
        GIT_SHALLOW TRUE)

    # load library into our cmake project
    # then can be used
    FetchContent_MakeAvailable(nlohmann_json)
    FetchContent_MakeAvailable(FMT)
    FetchContent_MakeAvailable(cxxopts)
    FetchContent_MakeAvailable(Catch2)
    FetchContent_MakeAvailable(spdlog)
endif()

# if not cmake project ? stick to AddGitSubmodule function
# then define own library target
# ex) call function in cmake module file
#     - add_git_submodule(external/json)

option(ENABLE_TESTING "Enable Unit Testing Build" ON)

# search for other CMakeLists.txt files in subdirectories
add_subdirectory(src) # library
add_subdirectory(configured)
add_subdirectory(external)
add_subdirectory(app)
add_subdirectory(tests) # other executable

if(COMPILE_EXECUTABLE)

else()
    # message when configure. not when we build
    # ex) cmake .. -> '..' means configure
    message("Without exe. compiling")
endif()

# which generator should be used
# generator is the build system that cmake uses under the hood

# build type
# - Debug : no optimization
# - Release : high optimization

# INSTALL TARGETS
# - able to install our executable and library 
# like any other software

# - option to install executable 
install(
    TARGETS ${EXECUTABLE_NAME}
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin)

# - option to install library
install(
    TARGETS ${LIBRARY_NAME}
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib)