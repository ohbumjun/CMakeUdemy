# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "D:/Coding/CodingStudyStuff/gameStudy/CMakeUdemy/build/_deps/cxxopts-src"
  "D:/Coding/CodingStudyStuff/gameStudy/CMakeUdemy/build/_deps/cxxopts-build"
  "D:/Coding/CodingStudyStuff/gameStudy/CMakeUdemy/build/_deps/cxxopts-subbuild/cxxopts-populate-prefix"
  "D:/Coding/CodingStudyStuff/gameStudy/CMakeUdemy/build/_deps/cxxopts-subbuild/cxxopts-populate-prefix/tmp"
  "D:/Coding/CodingStudyStuff/gameStudy/CMakeUdemy/build/_deps/cxxopts-subbuild/cxxopts-populate-prefix/src/cxxopts-populate-stamp"
  "D:/Coding/CodingStudyStuff/gameStudy/CMakeUdemy/build/_deps/cxxopts-subbuild/cxxopts-populate-prefix/src"
  "D:/Coding/CodingStudyStuff/gameStudy/CMakeUdemy/build/_deps/cxxopts-subbuild/cxxopts-populate-prefix/src/cxxopts-populate-stamp"
)

set(configSubDirs Debug)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "D:/Coding/CodingStudyStuff/gameStudy/CMakeUdemy/build/_deps/cxxopts-subbuild/cxxopts-populate-prefix/src/cxxopts-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "D:/Coding/CodingStudyStuff/gameStudy/CMakeUdemy/build/_deps/cxxopts-subbuild/cxxopts-populate-prefix/src/cxxopts-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()