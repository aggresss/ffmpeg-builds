
INCLUDE(ExternalProject)
INCLUDE_DIRECTORIES(${CMAKE_BINARY_DIR}/include)
LINK_DIRECTORIES(${CMAKE_BINARY_DIR}/lib)
SET(ENV{PATH} ${CMAKE_BINARY_DIR}/bin:$ENV{PATH})
SET(ENV{PKG_CONFIG_PATH} ${CMAKE_BINARY_DIR}/lib/pkgconfig)

EXTERNALPROJECT_ADD(
  ffmpeg
  # https://ffmpeg.org/download.html
  URL ${CMAKE_SOURCE_DIR}/vendor/ffmpeg-4.3.6.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh ffmpeg
  CONFIGURE_COMMAND
      PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure
        --prefix=${CMAKE_BINARY_DIR}
        --datadir=${CMAKE_BINARY_DIR}/etc
        --enable-shared
        --enable-static
        --enable-gpl
        --enable-version3
        --enable-nonfree
        --enable-runtime-cpudetect
        --disable-doc
        --disable-debug
        --disable-ffplay
        --disable-indevs
        --disable-outdevs

  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)
