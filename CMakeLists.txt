cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

set(PROJECT_NAME
  scavenge
)
set(LIBRARY_NAME
  scavenge
)
set(LIBRARY_COMMON_DIR
  common
)
set(LIBRARY_SOURCE_DIR
  src
)
set(LIBRARY_INCLUDE_DIR
  include
)
set(LIBRARY_HEADERS_DIR
  ${LIBRARY_INCLUDE_DIR}/${LIBRARY_NAME}
)
set(LIBRARY_HEADERS
  ${LIBRARY_INCLUDE_DIR}/scavenge.h
)
set(LIBRARY_SOURCE
  ${LIBRARY_SOURCE_DIR}/config.cu
  ${LIBRARY_SOURCE_DIR}/cuda_interface.cu
  ${LIBRARY_SOURCE_DIR}/particle.cu
  ${LIBRARY_SOURCE_DIR}/vec2.cu
  ${LIBRARY_SOURCE_DIR}/pso.cu
)

project(${PROJECT_NAME} LANGUAGES CXX CUDA)

add_library(${LIBRARY_NAME} STATIC
  ${LIBRARY_HEADERS}
  ${LIBRARY_SOURCE}
)

target_compile_features(${LIBRARY_NAME} PUBLIC cxx_std_11)

set_target_properties(${LIBRARY_NAME}
  PROPERTIES CUDA_SEPARABLE_COMPILATION ON
)

target_include_directories(${LIBRARY_NAME} PRIVATE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/${LIBRARY_NAME}>
  $<INSTALL_INTERFACE:include/${LIBRARY_NAME}>
)

target_include_directories(${LIBRARY_NAME} PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
)