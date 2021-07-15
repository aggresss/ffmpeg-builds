
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

EXTERNALPROJECT_ADD(
  zlib
  # URL https://github.com/madler/zlib/archive/v1.2.11.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/zlib-v1.2.11.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh zlib
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --static
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  openssl
  # URL https://www.openssl.org/source/old/1.1.1/openssl-1.1.1i.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/openssl-1.1.1i.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh openssl
  CONFIGURE_COMMAND ./config no-shared no-idea no-mdc2 no-rc5 --prefix=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make depend && make
  INSTALL_COMMAND make install_sw
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  opencore-amr
  # URL https://downloads.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-0.1.5.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/opencore-amr-0.1.5.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh opencore-amr
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  fdkaac
  # URL https://downloads.sourceforge.net/project/opencore-amr/fdk-aac/fdk-aac-2.0.2.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/fdk-aac-2.0.2.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh fdkaac
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  lame
  # URL https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/lame-3.100.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh lame
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  libogg
  # URL https://downloads.xiph.org/releases/ogg/libogg-1.3.5.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libogg-1.3.5.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libogg
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  speex
  DEPENDS libogg
  # URL https://downloads.xiph.org/releases/speex/speex-1.2.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/speex-1.2.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh speex
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR}
    --disable-shared
    --enable-sse
    --disable-oggtest
    --with-ogg=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  libvorbis
  DEPENDS libogg
  # URL https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libvorbis-1.3.7.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libvorbis
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-oggtest --with-ogg=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  libtheora
  DEPENDS libogg
  # URL http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2
  URL ${CMAKE_SOURCE_DIR}/vendor/libtheora-1.1.1.tar.bz2
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libtheora
  CONFIGURE_COMMAND ./configure
    --prefix=${CMAKE_BINARY_DIR}
    --with-pic
    --enable-static
    --disable-shared
    --disable-oggtest
    --disable-vorbistest
    --disable-asm
    --disable-spec
    --disable-examples
    --disable-doc
    --with-ogg=${CMAKE_BINARY_DIR}
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  opus
  # URL https://downloads.xiph.org/releases/opus/opus-1.3.1.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/opus-1.3.1.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh opus
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --disable-doc
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  xvidcore
  DEPENDS nasm
  # URL https://downloads.xvid.com/downloads/xvidcore-1.3.7.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/xvidcore-1.3.7.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh xvidcore
  CONFIGURE_COMMAND cd build/generic && PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND cd build/generic && PATH=$ENV{PATH} make
  INSTALL_COMMAND cd build/generic && make install
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  x264
  DEPENDS nasm
  # GIT_REPOSITORY git://git.videolan.org/x264.git
  URL ${CMAKE_SOURCE_DIR}/vendor/x264-20210121-1641-stable.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh x264
  CONFIGURE_COMMAND PATH=$ENV{PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  x265
  DEPENDS nasm
  # URL https://bitbucket.org/multicoreware/x265/downloads/x265_3.5.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/x265_3.5.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh x265
  CONFIGURE_COMMAND cd build/linux && PATH=$ENV{PATH} cmake
    -G "Unix Makefiles"
    -D CMAKE_INSTALL_PREFIX:PATH=${CMAKE_BINARY_DIR}
    -D ENABLE_CLI:BOOL=OFF
    -D ENABLE_LIBNUMA:BOOL=OFF
    -D ENABLE_SHARED:BOOL=OFF ../../source
  BUILD_COMMAND cd build/linux && PATH=$ENV{PATH} make
  INSTALL_COMMAND cd build/linux && PATH=$ENV{PATH} make install
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  aom
  DEPENDS nasm
  # GIT_REPOSITORY git://aomedia.googlesource.com/aom.git
  URL ${CMAKE_SOURCE_DIR}/vendor/aom-v2.0.2.tgz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh aom
  CONFIGURE_COMMAND cd build && PATH=$ENV{PATH} cmake ..
    -DENABLE_TOOLS:BOOL=OFF
    -DENABLE_EXAMPLES:BOOL=OFF
    -DENABLE_TESTDATA:BOOL=OFF
    -DENABLE_TESTS:BOOL=OFF
    -DENABLE_DOCS:BOOL=OFF
    -DENABLE_CCACHE:BOOL=ON
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}
  BUILD_COMMAND cd build && PATH=$ENV{PATH} make
  INSTALL_COMMAND cd build && PATH=$ENV{PATH} make install
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  libvpx
  DEPENDS nasm
  # URL https://chromium.googlesource.com/webm/libvpx/+archive/v1.9.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libvpx-1.9.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libvpx
  CONFIGURE_COMMAND PATH=$ENV{PATH} ./configure
    --prefix=${CMAKE_BINARY_DIR}
    --disable-shared
    --disable-examples
    --disable-tools
    --disable-docs
    --disable-unit-tests
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  srt
  DEPENDS openssl
  # URL https://github.com/Haivision/srt/archive/v1.4.2.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/srt-v1.4.2.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh srt
  CONFIGURE_COMMAND mkdir -p build && cd build && PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} cmake
    -DENABLE_SHARED=0
    -DENABLE_APPS=0
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR} ..
  BUILD_COMMAND cd build && PATH=$ENV{PATH} make
  INSTALL_COMMAND cd build && PATH=$ENV{PATH} make install
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  freetype
  # URL https://download.savannah.gnu.org/releases/freetype/freetype-2.10.4.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/freetype-2.10.4.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh freetype
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure
    --prefix=${CMAKE_BINARY_DIR}
    --disable-shared
    --enable-static
    --without-bzip2
    --without-png
    --without-brotli
  BUILD_COMMAND make
  INSTALL_COMMAND make install && ln -s ${CMAKE_BINARY_DIR}/include/freetype2 ${CMAKE_BINARY_DIR}/include/freetype2/freetype
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  fribidi
  # URL https://github.com/fribidi/fribidi/releases/download/v1.0.10/fribidi-1.0.10.tar.xz
  URL ${CMAKE_SOURCE_DIR}/vendor/fribidi-1.0.10.tar.xz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh fribidi
  CONFIGURE_COMMAND ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  expat
  # URL https://github.com/libexpat/libexpat/releases/download/R_2_2_10/expat-2.2.10.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/expat-2.2.10.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh expat
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  fontconfig
  DEPENDS freetype expat
  # URL https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.13.93.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/fontconfig-2.13.93.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh fontconfig
  CONFIGURE_COMMAND ./configure
    --prefix=${CMAKE_BINARY_DIR}
    --enable-static
    --disable-shared
    --disable-docs
    --disable-nls
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  harfbuzz
  DEPENDS freetype fontconfig
  # URL https://github.com/harfbuzz/harfbuzz/releases/download/2.8.0/harfbuzz-2.8.0.tar.xz
  URL ${CMAKE_SOURCE_DIR}/vendor/harfbuzz-2.8.0.tar.xz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh harfbuzz
  CONFIGURE_COMMAND PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
)

EXTERNALPROJECT_ADD(
  libass
  DEPENDS nasm freetype fribidi fontconfig harfbuzz
  # URL https://github.com/libass/libass/releases/download/0.15.0/libass-0.15.0.tar.gz
  URL ${CMAKE_SOURCE_DIR}/vendor/libass-0.15.0.tar.gz
  PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh libass
  CONFIGURE_COMMAND PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure --prefix=${CMAKE_BINARY_DIR} --disable-shared --enable-static
  BUILD_COMMAND PATH=$ENV{PATH} make
  BUILD_IN_SOURCE 1
)

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  EXTERNALPROJECT_ADD(
    ffmpeg
    DEPENDS
      zlib nasm openssl
      opencore-amr fdkaac lame libogg opus speex
      libvorbis libtheora xvidcore x264 x265 aom libvpx
      srt
      freetype fribidi fontconfig libass
    # URL https://ffmpeg.org/releases/ffmpeg-4.4.tar.gz
    URL ${CMAKE_SOURCE_DIR}/vendor/ffmpeg-4.4.tar.gz
    PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh ffmpeg
    CONFIGURE_COMMAND
        PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure
          --prefix=${CMAKE_BINARY_DIR}
          --datadir=${CMAKE_BINARY_DIR}/etc
          --disable-shared
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
          --extra-libs=-lvorbis\ -logg\ -lharfbuzz\ -lfontconfig\ -lfreetype\ -lexpat\ -lcrypto\ -lz\ -lpthread\ -lstdc++\ -lm\ -ldl
          --enable-zlib
          --enable-bzlib
          --enable-lzma
          --enable-openssl
          --enable-libopencore-amrnb
          --enable-libopencore-amrwb
          --enable-libfdk-aac
          --enable-libmp3lame
          --enable-libopus
          --enable-libspeex
          --enable-libvorbis
          --enable-libtheora
          --enable-libxvid
          --enable-libx264
          --enable-libx265
          --enable-libvpx
          --enable-libaom
          --enable-libsrt
          --enable-libfreetype
          --enable-libfribidi
          --enable-fontconfig
          --enable-libass
    BUILD_COMMAND PATH=$ENV{PATH} make
    BUILD_IN_SOURCE 1
  )
elseif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  EXTERNALPROJECT_ADD(
    ffmpeg
    DEPENDS
      zlib nasm openssl
      opencore-amr fdkaac lame libogg opus speex
      libvorbis libtheora xvidcore x264 x265 aom libvpx
      srt
      freetype fribidi fontconfig libass
    # URL https://ffmpeg.org/releases/ffmpeg-4.4.tar.gz
    URL ${CMAKE_SOURCE_DIR}/vendor/ffmpeg-4.4.tar.gz
    PATCH_COMMAND ${CMAKE_SOURCE_DIR}/patches/patch-manager.sh ffmpeg
    CONFIGURE_COMMAND
        PATH=$ENV{PATH} PKG_CONFIG_PATH=$ENV{PKG_CONFIG_PATH} ./configure
          --prefix=${CMAKE_BINARY_DIR}
          --datadir=${CMAKE_BINARY_DIR}/etc
          --disable-asm
          --disable-shared
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
          --extra-ldflags=-Wl,-no_compact_unwind\ -L${CMAKE_BINARY_DIR}/lib
          --extra-libs=-lvorbis\ -logg\ -lharfbuzz\ -lfontconfig\ -lfreetype\ -lexpat\ -lcrypto\ -lz\ -lpthread\ -lstdc++\ -lm\ -ldl
          --enable-zlib
          --enable-bzlib
          --enable-lzma
          --enable-openssl
          --enable-libopencore-amrnb
          --enable-libopencore-amrwb
          --enable-libfdk-aac
          --enable-libmp3lame
          --enable-libopus
          --enable-libspeex
          --enable-libvorbis
          --enable-libtheora
          --enable-libxvid
          --enable-libx264
          --enable-libx265
          --enable-libvpx
          --enable-libaom
          --enable-libsrt
          --enable-libfreetype
          --enable-libfribidi
          --enable-fontconfig
          --enable-libass
    BUILD_COMMAND PATH=$ENV{PATH} make
    BUILD_IN_SOURCE 1
  )
endif()