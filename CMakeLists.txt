# Require at least cmake 2.8.4
cmake_minimum_required(VERSION 2.8.4 FATAL_ERROR)

# Name of this project
project(QwAnalysis)

# Local path for cmake modules, before ${CMAKE_ROOT}/Modules/ is checked
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")

# C++11 standard if avialable
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
if(COMPILER_SUPPORTS_CXX11)
        message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has C++11 support.")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
elseif(COMPILER_SUPPORTS_CXX0X)
        message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has C++0x support.")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
else()
        message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support.")
endif()

# Add the project include directory
include_directories(
  ${CMAKE_CURRENT_BINARY_DIR}/include
  ${CMAKE_CURRENT_SOURCE_DIR}/evio/include
  ${CMAKE_CURRENT_SOURCE_DIR}/Parity/include
  ${CMAKE_CURRENT_SOURCE_DIR}/Analysis/include
  ${CMAKE_CURRENT_SOURCE_DIR}/Tracking/include
  )

# Put all QwAnalysis files in my_project_sources
file(GLOB my_project_headers
  ${CMAKE_CURRENT_SOURCE_DIR}/Analysis/include/*.h
  ${CMAKE_CURRENT_SOURCE_DIR}/Parity/include/*.h
  ${CMAKE_CURRENT_SOURCE_DIR}/Tracking/include/*.h
  ${CMAKE_CURRENT_BINARY_DIR}/include/QwSVNVersion.h
  )
file(GLOB my_project_sources
  ${CMAKE_CURRENT_SOURCE_DIR}/Analysis/src/*.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/Parity/src/*.cc
  ${CMAKE_CURRENT_SOURCE_DIR}/Tracking/src/*.cc
  )

# Put all evio files in my_project_sources (exclude THaEtClient)
file(GLOB my_evio_headers
  ${CMAKE_CURRENT_SOURCE_DIR}/evio/include/THaCoda*.h
  ${CMAKE_CURRENT_SOURCE_DIR}/evio/include/evio.h
  )
file(GLOB my_evio_sources
  ${CMAKE_CURRENT_SOURCE_DIR}/evio/src/THaCoda*.C
  ${CMAKE_CURRENT_SOURCE_DIR}/evio/src/evio.C
  ${CMAKE_CURRENT_SOURCE_DIR}/evio/src/swap_util.C
  )

# Load ROOT and setup include directory
find_package(ROOT REQUIRED)
include_directories(${ROOT_INCLUDE_DIR})
set(ROOT_LIBRARIES ${ROOT_LIBRARIES} -lNew -lGui -lMinuit2)

# Load MYSQLPP
find_package(MYSQLPP REQUIRED)
include_directories(${MYSQLPP_INCLUDE_DIR})

# Find Boost libraries
# There seems to be a bug starting in version 2.8.4 of CMake's boost
# finding process. As such, we'll disable it here and require 2.8.4 or higher
SET( Boost_NO_BOOST_CMAKE ON )
find_package(Boost COMPONENTS program_options filesystem system regex REQUIRED)
include_directories(${Boost_INCLUDE_DIRS})
link_directories(${Boost_LIBRARY_DIR})

# Create dictionaries for headers that contain "ClassDef" if ROOT version < 5.90
if(ROOT_VERSION VERSION_LESS 5.90)
message("Generating evio dictionaries for ROOT ${ROOT_VERSION}...")
foreach(file ${my_evio_headers})
  # Find the header files that have uncommented ClassDef lines
  execute_process(COMMAND grep -l "[^/]ClassDef" ${file} OUTPUT_VARIABLE result)
  if(result)
    # Get path and filename without extension
    get_filename_component(file_path ${file} PATH)
    get_filename_component(file_name ${file} NAME_WE)
    # Add dictionary target with possible LinkDef file
    file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/dictionary)
    set(dict ${CMAKE_CURRENT_BINARY_DIR}/dictionary/${file_name}Dict)
    ROOT_GENERATE_DICTIONARY(
      ${dict}
      ${file}
      OPTIONS -p)
    # Add dictionary to evio sources
    set(my_evio_sources ${my_evio_sources} ${dict}.cxx)
  endif()
endforeach()
message("Generating QwAnalysis dictionaries for ROOT ${ROOT_VERSION}...")
foreach(file ${my_project_headers})
  # Find the header files that have uncommented ClassDef lines
  execute_process(COMMAND grep -l "[^/]ClassDef" ${file} OUTPUT_VARIABLE result)
  if(result)
    # Get path and filename without extension
    get_filename_component(file_path ${file} PATH)
    get_filename_component(file_name ${file} NAME_WE)
    # Add dictionary target with possible LinkDef file
    file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/dictionary)
    set(dict ${CMAKE_CURRENT_BINARY_DIR}/dictionary/${file_name}Dict)
    set(linkdef ${file_path}/${file_name}LinkDef.h)
    if(EXISTS ${linkdef})
      ROOT_GENERATE_DICTIONARY(
        ${dict}
        ${file}
        LINKDEF ${linkdef}
        OPTIONS -p)
    else()
      ROOT_GENERATE_DICTIONARY(
        ${dict}
        ${file}
        OPTIONS -p)
    endif()
    # Add dictionary to project sources
    set(my_project_sources ${my_project_sources} ${dict}.cxx)
  endif()
endforeach()
else()
message("No QwAnalysis dictionaries needed for ROOT ${ROOT_VERSION}.")
endif()


# Add target of QwSVNVersion.h
add_custom_command(
  OUTPUT  ${CMAKE_CURRENT_BINARY_DIR}/include/QwSVNVersion.h.does_not_exist
  COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/bin/qwsvnversion.sh ${CMAKE_CURRENT_BINARY_DIR}/include/QwSVNVersion.h
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  COMMENT "Getting QwSVNVersion information"
  )
add_custom_command(
  OUTPUT  ${CMAKE_CURRENT_BINARY_DIR}/include/QwSVNVersion.h
  COMMAND echo -n
  DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/include/QwSVNVersion.h.does_not_exist
  )
set_property(
  SOURCE ${CMAKE_SOURCE_DIR}/Analysis/src/QwOptions.cc ${CMAKE_SOURCE_DIR}/Analysis/src/QwRunCondition.cc
  APPEND PROPERTY OBJECT_DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/include/QwSVNVersion.h
  )

# Link the evio library
add_library(evio SHARED ${my_evio_sources})
target_link_libraries(evio)

# Link the ROOT libraries
add_library(QwAnalysis SHARED ${CMAKE_CURRENT_BINARY_DIR}/include/QwSVNVersion.h ${my_project_sources} ${my_project_headers})
target_link_libraries(QwAnalysis
  evio ${ROOT_LIBRARIES} ${MYSQLPP_LIBRARIES} ${Boost_LIBRARIES})


# Add the target executables
file(GLOB exefiles
  ${CMAKE_SOURCE_DIR}/Parity/main/*.cc
  ${CMAKE_SOURCE_DIR}/Analysis/main/*.cc
  ${CMAKE_SOURCE_DIR}/Tracking/main/*.cc
  )
foreach(file ${exefiles})
  get_filename_component(filename ${file} NAME_WE)
  string(TOLOWER ${filename} filelower)
  add_executable(${filelower} ${file})
  target_link_libraries(
    ${filelower}
    ${ROOT_LIBRARIES} ${MYSQLPP_LIBRARIES} ${Boost_LIBRARIES} QwAnalysis evio
    )
endforeach()

