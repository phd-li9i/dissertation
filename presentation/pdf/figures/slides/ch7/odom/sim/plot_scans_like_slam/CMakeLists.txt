cmake_minimum_required(VERSION 2.8.3)
project(s2msm)

#https://stackoverflow.com/a/38511897
SET(CMAKE_CXX_COMPILER /usr/bin/g++)
add_compile_options(-std=c++11 -Ofast)

#add_compile_options(-std=c++11)
#SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pg")
#SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -pg")
#SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -pg")

find_package(PkgConfig)
pkg_check_modules(csm REQUIRED csm)

find_package(CGAL REQUIRED)

find_package(PCL 1.7 REQUIRED)

INCLUDE_DIRECTORIES(include
  ${csm_INCLUDE_DIRS}
  ${PCL_INCLUDE_DIRS}
  /usr/include/eigen3/)

# Utils ########################################################################
add_library(utils_lib
  src/utils.cpp)

target_link_libraries(utils_lib
  CGAL::CGAL_Core)

# Dataset utils ################################################################
add_library(dataset_utils_lib
  src/dataset_utils.cpp)

target_link_libraries(dataset_utils_lib
  utils_lib)

# Dump##########################################################################
add_library(dump_lib
  src/dump.cpp)

target_link_libraries(dump_lib
  CGAL::CGAL_Core)

# Intersections ################################################################
add_library(intersections_lib
  src/intersections.cpp)

target_link_libraries(intersections_lib
  utils_lib)

# Find #########################################################################
add_library(find_lib
  src/find.cpp)

target_link_libraries(find_lib
  utils_lib
  intersections_lib)

# Scan completion ##############################################################
add_library(scan_completion_lib
  src/scan_completion.cpp)

target_link_libraries(scan_completion_lib
  utils_lib
  intersections_lib)

# DFT utils ####################################################################
add_library(dft_utils_lib
  src/dft_utils.cpp)

target_link_libraries(dft_utils_lib
  fftw3)

# Translation ##################################################################
add_library(translation_lib
  src/translation.cpp)

target_link_libraries(translation_lib
  intersections_lib
  fftw3
  utils_lib
  dft_utils_lib)

# Rotation #####################################################################
add_library(rotation_lib
  src/rotation.cpp)

target_link_libraries(rotation_lib
  intersections_lib
  fftw3
  utils_lib
  dft_utils_lib)

# CSM ##########################################################################
link_directories(${csm_LIBRARY_DIRS})
add_library(cs2msm_lib src/cs2msm.cpp)
add_library(gpm_lib src/gpm.cpp)
target_link_libraries(cs2msm_lib ${csm_LIBRARIES} gpm_lib utils_lib)


# Match ########################################################################
add_library(match_lib
  src/match.cpp)

link_directories(${PCL_LIBRARY_DIRS})
add_definitions(${PCL_DEFINITIONS})

target_link_libraries(match_lib
  ${PCL_LIBRARIES}
  translation_lib
  fftw3
  rotation_lib
  utils_lib
  find_lib
  cs2msm_lib)


# s2msm ########################################################################
add_library(s2msm_lib
  src/s2msm.cpp)

target_link_libraries(s2msm_lib
  dump_lib
  scan_completion_lib
  fftw3
  utils_lib
  dataset_utils_lib
  intersections_lib
  match_lib
  find_lib)

# The executable ###############################################################
add_executable(s2msm_node
  src/s2msm_node.cpp)

target_link_libraries(s2msm_node
  s2msm_lib)
