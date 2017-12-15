#!/bin/bash
set -e

### From https://hub.docker.com/r/jrottenberg/ffmpeg/
FFMPEG_VERSION=3.4
FAAC_VERSION=1.28
FDKAAC_VERSION=0.1.4
LAME_VERSION=3.99.5
OGG_VERSION=1.3.2
OPUS_VERSION=1.1.1
THEORA_VERSION=1.1.1
YASM_VERSION=1.3.0
VORBIS_VERSION=1.3.5
VPX_VERSION=1.6.0
XVID_VERSION=1.3.4
X265_VERSION=2.0
X264_VERSION=20171213-2245-stable
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
SRC=/usr/local

## yasm http://yasm.tortall.net/
DIR=$(mktemp -d) && cd ${DIR} && \
curl -L https://github.com/yasm/yasm/archive/v${YASM_VERSION}.tar.gz | \
tar -zx --strip-components=1 && \
./autogen.sh && \
./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir=${DIR} && \
make && \
make install && \
make distclean && \
rm -rf ${DIR}


## x264 http://www.videolan.org/developers/x264.html
DIR=$(mktemp -d) && cd ${DIR} && \
curl --insecure  -L https://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-${X264_VERSION}.tar.bz2 | \
tar -jx --strip-components=1 && \
./configure --prefix="${SRC}" --bindir="${SRC}/bin" --enable-pic --enable-static && \
make && \
make install && \
make distclean && \
rm -rf ${DIR}


## x265 http://x265.org/
DIR=$(mktemp -d) && cd ${DIR} && \
curl -L https://download.videolan.org/pub/videolan/x265/x265_${X265_VERSION}.tar.gz  | \
tar -zx && \
cd x265_${X265_VERSION}/build/linux && \
./multilib.sh && \
make -C 8bit install && \
rm -rf ${DIR}

# DIR=$(mktemp -d) && cd ${DIR} && \
# ## libogg https://www.xiph.org/ogg/
# curl -L http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz | \
# tar -zx --strip-components=1 && \
# ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --datadir=${DIR} && \
# make && \
# make install && \
# make distclean && \
# rm -rf ${DIR}
#
# DIR=$(mktemp -d) && cd ${DIR} && \
# ## libopus https://www.opus-codec.org/
# curl -sL http://downloads.xiph.org/releases/opus/opus-${OPUS_VERSION}.tar.gz | \
# tar -zx --strip-components=1 && \
# autoreconf -fiv && \
# ./configure --prefix="${SRC}" --disable-shared --datadir="${DIR}" && \
# make && \
# make install && \
# make distclean && \
# rm -rf ${DIR}

# DIR=$(mktemp -d) && cd ${DIR} && \
# ## libvorbis https://xiph.org/vorbis/
# curl -sL http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz | \
# tar -zx --strip-components=1 && \
# ./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" \
# --disable-shared --datadir="${DIR}" && \
# make && \
# make install && \
# make distclean && \
# rm -rf ${DIR}
#
# DIR=$(mktemp -d) && cd ${DIR} && \
# #@ libtheora http://www.theora.org/
# curl -sL http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.bz2 | \
# tar -jx --strip-components=1 && \
# ./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" \
# --disable-shared --datadir="${DIR}" && \
# make && \
# make install && \
# make distclean && \
# rm -rf ${DIR}

# DIR=$(mktemp -d) && cd ${DIR} && \
# ## libvpx https://www.webmproject.org/code/
# curl -sL https://codeload.github.com/webmproject/libvpx/tar.gz/v${VPX_VERSION} | \
# tar -zx --strip-components=1 && \
# ./configure --prefix="${SRC}" --enable-vp8 --enable-vp9 --disable-examples --disable-docs && \
# make && \
# make install && \
# make clean && \
# rm -rf ${DIR}
#
# DIR=$(mktemp -d) && cd ${DIR} && \
# ## libmp3lame http://lame.sourceforge.net/
# curl -sL https://downloads.sf.net/project/lame/lame/${LAME_VERSION%.*}/lame-${LAME_VERSION}.tar.gz | \
# tar -zx --strip-components=1 && \
# ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --enable-nasm --datadir="${DIR}" && \
# make && \
# make install && \
# make distclean&& \
# rm -rf ${DIR}

# DIR=$(mktemp -d) && cd ${DIR} && \
# ## xvid https://www.xvid.com/
# curl -sL http://downloads.xvid.org/downloads/xvidcore-${XVID_VERSION}.tar.gz | \
# tar -zx && \
# cd xvidcore/build/generic && \
# ./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir="${DIR}" && \
# make && \
# make install && \
# rm -rf ${DIR}
#
# DIR=$(mktemp -d) && cd ${DIR} && \
# ## fdk-aac https://github.com/mstorsjo/fdk-aac
# curl -sL https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz | \
# tar -zx --strip-components=1 && \
# autoreconf -fiv && \
# ./configure --prefix="${SRC}" --disable-shared --datadir="${DIR}" && \
# make && \
# make install && \
# make distclean && \
# rm -rf ${DIR}

# --enable-libfdk_aac \
# --enable-libmp3lame \
# --enable-libopus \
# --enable-libtheora \
# --enable-libvorbis \
# --enable-libvpx \
#   --enable-libxvid \

DIR=$(mktemp -d) && cd ${DIR} && \
## ffmpeg https://ffmpeg.org/
curl -sL http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | \
tar -zx --strip-components=1 && \
./configure --prefix="${SRC}" \
          --extra-cflags="-I${SRC}/include" \
          --extra-ldflags="-L${SRC}/lib" \
          --bindir="${SRC}/bin" \
          --disable-doc \
          --extra-libs=-ldl \
          --enable-version3 \
          --enable-libx264 \
          --enable-libx265 \
          --enable-gpl \
          --enable-avresample \
          --enable-postproc \
          --enable-nonfree \
          --disable-debug \
          --enable-small \
          --enable-openssl && \
make && \
make install && \
make distclean && \
hash -r && \
cd tools && \
make qt-faststart && \
cp qt-faststart ${SRC}/bin && \
rm -rf ${DIR} &&
ldconfig -v &&
ffmpeg -buildconf
