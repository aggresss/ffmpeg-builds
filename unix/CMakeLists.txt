
INCLUDE(ExternalProject)
INCLUDE_DIRECTORIES(${CMAKE_BINARY_DIR}/include)
LINK_DIRECTORIES(${CMAKE_BINARY_DIR}/lib)
SET(ENV{PATH} ${CMAKE_BINARY_DIR}/bin:$ENV{PATH})
SET(ENV{PKG_CONFIG_PATH} ${CMAKE_BINARY_DIR}/lib/pkgconfig)

EXTERNALPROJECT_ADD(
  nasm
  # URL https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/nasm-2.15.05.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh nasm
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  EXTERNALPROJECT_ADD(
    ffmpeg
    DEPENDS
      nasm
    # URL https://ffmpeg.org/releases/ffmpeg-4.4.tar.gz
    URL ${CMAKE_SOURCE_DIR}/vendor/ffmpeg-4.4.tar.gz
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
          --extra-cflags=-I${CMAKE_BINARY_DIR}/include\ --static
          --extra-ldflags=-L${CMAKE_BINARY_DIR}/lib
          --extra-libs=-lpthread\ -lstdc++\ -lm\ -ldl

    BUILD_COMMAND PATH=$ENV{PATH} make
    BUILD_IN_SOURCE 1
  )
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  EXTERNALPROJECT_ADD(
    ffmpeg
    DEPENDS
       nasm
    # URL https://ffmpeg.org/releases/ffmpeg-4.4.tar.gz
    URL ${CMAKE_SOURCE_DIR}/vendor/ffmpeg-4.4.tar.gz
    PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh ffmpeg
    CONFIGURE_COMMAND
        PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure
          --prefix=${CMAKE_BINARY_DIR}
          --datadir=${CMAKE_BINARY_DIR}/etc
          --disable-asm
          --enable-shared
          --enable-static
          --enable-gpl
          --enable-version3
          --enable-nonfree
          --enable-runtime-cpudetect
          --disable-doc
          --disable-debug
          --enable-ffplay
          --disable-indevs
          --disable-outdevs
          --extra-cflags=-I${CMAKE_BINARY_DIR}/include\ --static
          --extra-ldflags=-Wl,-no_compact_unwind\ -L${CMAKE_BINARY_DIR}/lib
          --extra-libs=-lpthread\ -lstdc++\ -lm\ -ldl

    BUILD_COMMAND PATH=$ENV{PATH} make
    BUILD_IN_SOURCE 1
  )
endif()