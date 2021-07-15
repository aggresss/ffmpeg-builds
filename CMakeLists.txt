# ------------------------------------------------------------------------------
# CMakeLists.txt for Project Top Level
# ------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.0)

# You probably should not build things in tree anyway
if (CMAKE_BINARY_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  message(FATAL_ERROR "Building in-source is not supported! Create a build dir and remove ${CMAKE_SOURCE_DIR}/CMakeCache.txt")
endif()

# ------------------------------------------------------------------------------
# Project
# ------------------------------------------------------------------------------

project("ffmpeg-builds" C)

# ------------------------------------------------------------------------------
# Get and Display infomation
# ------------------------------------------------------------------------------

message(STATUS "CMake version: " ${CMAKE_VERSION})
message(STATUS "CMake system name: " ${CMAKE_SYSTEM_NAME})

# ------------------------------------------------------------------------------
# OS Specific
# ------------------------------------------------------------------------------

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  add_subdirectory(unix)
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  add_subdirectory(unix)
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Windows")
  message(DEPRECATION "No support for system: " ${CMAKE_SYSTEM_NAME})
else()
  message(DEPRECATION "No support for system: " ${CMAKE_SYSTEM_NAME})
endif()
