# 0. create source and cmakefile
# 1. create build folder
# 2. cd build
# 3. cmake .. (Generating the build files / configure the project)
# 4. cmake --build . (Compile the project, make final exe file)
# 5. ./Executable

cmake_minimum_required(VERSION 3.22)

# set the project name
project(CPPProjectCMake 
VERSION 
1.0.0 
LANGUAGES C CXX)

# every target in our project set to use C++17
set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED On)

# ex) some c variable not in C++ standard. but can be used in gcc
#     disable these kinds of examples 
set(CMAKE_CXX_EXTENSIONS        OFF)

# can pass variable to set 'COMPILE_EXECUTABLE' value in command line
# ex) cmake .. -DCOMPILE_EXECUTABLE=ON
option(COMPILE_EXECUTABLE "Whether to compile the executable" ON)

# define variable. all used in subdirectories cmakefiles
set(LIBRARY_NAME "Library")
set(EXECUTABLE_NAME "Executable")
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

# include cmake module files 
# reference : already predefined cmake modules exist in my cmake version
include(AddGitSubmodule) 
include(Docs) 

# build in cmake modules
include(FetchContent)

# main idea
# - declare which github repository to use -> be cloned to build directory
# - GIT_REPOSITORY needs to be cmake project
FetchContent_Declare(
    # defined in other github repo cmakelist.txt as project name
    # ex) project(CPPProjectCMake VERSION 1.0.0 LANGUAGES C CXX)
    nlohmann_json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    # which version
    GIT_TAG v3.11.3
    # would not clone recursively
    GIT_SHALLOW TRUE
    )

FetchContent_Declare(
    FMT
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_SHALLOW TRUE
    )

FetchContent_Declare(
    cxxopts
    GIT_REPOSITORY https://github.com/jarro2783/cxxopts.git
    GIT_TAG v3.1.1
    GIT_SHALLOW TRUE
)

FetchContent_Declare(
    Catch2
    GIT_REPOSITORY https://github.com/catchorg/Catch2
    GIT_TAG v2.13.9
    GIT_SHALLOW TRUE
)

FetchContent_Declare(
    spdlog
    GIT_REPOSITORY https://github.com/gabime/spdlog
    GIT_TAG v1.11.0
    GIT_SHALLOW TRUE)

# load library into our cmake project
# then can be used
FetchContent_MakeAvailable(nlohmann_json)
FetchContent_MakeAvailable(FMT)
FetchContent_MakeAvailable(cxxopts)
FetchContent_MakeAvailable(Catch2)
FetchContent_MakeAvailable(spdlog)

# if not cmake project ? stick to AddGitSubmodule function
# then define own library target 
# ex) call function in cmake module file
#     - add_git_submodule(external/json)

# search for other CMakeLists.txt files in subdirectories
add_subdirectory(src) # library
add_subdirectory(configured)
add_subdirectory(external)
add_subdirectory(app)

if (COMPILE_EXECUTABLE)
else ()
    # message when configure. not when we build
    # ex) cmake .. -> '..' means configure
    message("Without exe. compiling")
endif()

# which generator should be used
# generator is the build system that cmake uses under the hood

# build type
# - Debug : no optimization
# - Release : high optimization