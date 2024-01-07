# if doxygen is installed 
find_package(Doxygen)

if (DOXYGEN_FOUND)
    # create a custom target that performs custom commands
    # only define utility target we can execute on console or terminal
    add_custom_target(
        # create a target called doc
        docs
        # DOXYGEN_EXECUTABLE set by find_package(Doxygen)
        # this file will be executed to generate documentation 
        COMMAND  ${DOXYGEN_EXECUTABLE} 
        # CMAKE_SOURCE_DIR is the absolute path to main cmakeFile. which is root directory  
        # CMAKE_BINARY_DIR : root build directory
        # place where 'doxygen command' will be run to generate documentation
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/docs
        COMMENT "Generating API documentation with Doxygen" VERBATIM)

        # ex) above command same as == cd docs -> doxygen -> create html files in docs/html
endif()