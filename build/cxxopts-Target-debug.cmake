# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(cxxopts_FRAMEWORKS_FOUND_DEBUG "") # Will be filled later
conan_find_apple_frameworks(cxxopts_FRAMEWORKS_FOUND_DEBUG "${cxxopts_FRAMEWORKS_DEBUG}" "${cxxopts_FRAMEWORK_DIRS_DEBUG}")

set(cxxopts_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET cxxopts_DEPS_TARGET)
    add_library(cxxopts_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET cxxopts_DEPS_TARGET
             PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Debug>:${cxxopts_FRAMEWORKS_FOUND_DEBUG}>
             $<$<CONFIG:Debug>:${cxxopts_SYSTEM_LIBS_DEBUG}>
             $<$<CONFIG:Debug>:>
             APPEND)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### cxxopts_DEPS_TARGET to all of them
conan_package_library_targets("${cxxopts_LIBS_DEBUG}"    # libraries
                              "${cxxopts_LIB_DIRS_DEBUG}" # package_libdir
                              "${cxxopts_BIN_DIRS_DEBUG}" # package_bindir
                              "${cxxopts_LIBRARY_TYPE_DEBUG}"
                              "${cxxopts_IS_HOST_WINDOWS_DEBUG}"
                              cxxopts_DEPS_TARGET
                              cxxopts_LIBRARIES_TARGETS  # out_libraries_targets
                              "_DEBUG"
                              "cxxopts"    # package_name
                              "${cxxopts_NO_SONAME_MODE_DEBUG}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${cxxopts_BUILD_DIRS_DEBUG} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Debug ########################################
    set_property(TARGET cxxopts::cxxopts
                 PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Debug>:${cxxopts_OBJECTS_DEBUG}>
                 $<$<CONFIG:Debug>:${cxxopts_LIBRARIES_TARGETS}>
                 APPEND)

    if("${cxxopts_LIBS_DEBUG}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET cxxopts::cxxopts
                     PROPERTY INTERFACE_LINK_LIBRARIES
                     cxxopts_DEPS_TARGET
                     APPEND)
    endif()

    set_property(TARGET cxxopts::cxxopts
                 PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Debug>:${cxxopts_LINKER_FLAGS_DEBUG}> APPEND)
    set_property(TARGET cxxopts::cxxopts
                 PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Debug>:${cxxopts_INCLUDE_DIRS_DEBUG}> APPEND)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET cxxopts::cxxopts
                 PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Debug>:${cxxopts_LIB_DIRS_DEBUG}> APPEND)
    set_property(TARGET cxxopts::cxxopts
                 PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Debug>:${cxxopts_COMPILE_DEFINITIONS_DEBUG}> APPEND)
    set_property(TARGET cxxopts::cxxopts
                 PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Debug>:${cxxopts_COMPILE_OPTIONS_DEBUG}> APPEND)

########## For the modules (FindXXX)
set(cxxopts_LIBRARIES_DEBUG cxxopts::cxxopts)
