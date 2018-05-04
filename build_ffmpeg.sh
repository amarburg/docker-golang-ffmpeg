#!/bin/sh

### From https://hub.docker.com/r/jrottenberg/ffmpeg/
FFMPEG_VERSION=3.4.2
FAAC_VERSION=1.28
FDKAAC_VERSION=0.1.6
LAME_VERSION=3.99.5
OGG_VERSION=1.3.2
OPUS_VERSION=1.1.1
THEORA_VERSION=1.1.1
NASM_VERSION=2.13.03
VORBIS_VERSION=1.3.5
VPX_VERSION=1.7.0
XVID_VERSION=1.3.4
X265_VERSION=2.0
X264_VERSION=20160826-2245-stable
PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
SRC=/usr/local

## NASM
DIR=$(mktemp -d) && cd ${DIR} && \
curl -L https://www.nasm.us/pub/nasm/releasebuilds/${NASM_VERSION}/nasm-${NASM_VERSION}.tar.gz | \
tar -zx --strip-components=1 && \
./autogen.sh && \
./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir=${DIR} && \
make -j && \
make install && \
make distclean && \
rm -rf ${DIR} && \
## x264 http://www.videolan.org/developers/x264.html
## videolan.org's certs aren't quite right, use --insecure
DIR=$(mktemp -d) && cd ${DIR} && \
curl -sL --insecure https://ftp.videolan.org/pub/videolan/x264/snapshots/last_stable_x264.tar.bz2 | \
tar -jx --strip-components=1 && \
./configure --prefix="${SRC}" --bindir="${SRC}/bin" --enable-static --enable-pic && \
make -j && \
make install && \
make distclean && \
rm -rf ${DIR} && \
DIR=$(mktemp -d) && cd ${DIR} && \
## x265 http://x265.org/
curl -sL https://download.videolan.org/pub/videolan/x265/x265_${X265_VERSION}.tar.gz  | \
tar -zx && \
cd x265_${X265_VERSION}/build/linux && \
./multilib.sh && \
make -C 8bit install && \
rm -rf ${DIR} && \
DIR=$(mktemp -d) && cd ${DIR} && \
## libogg https://www.xiph.org/ogg/
curl -sL http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz | \
tar -zx --strip-components=1 && \
./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --datadir=${DIR} && \
make -j && \
make install && \
make distclean && \
rm -rf ${DIR} && \
DIR=$(mktemp -d) && cd ${DIR} && \
## libopus https://www.opus-codec.org/
curl -sL http://downloads.xiph.org/releases/opus/opus-${OPUS_VERSION}.tar.gz | \
tar -zx --strip-components=1 && \
autoreconf -fiv && \
./configure --prefix="${SRC}" --disable-shared --datadir="${DIR}" && \
make -j && \
make install && \
make distclean && \
rm -rf ${DIR} && \
DIR=$(mktemp -d) && cd ${DIR} && \
## libvorbis https://xiph.org/vorbis/
curl -sL http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz | \
tar -zx --strip-components=1 && \
./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" \
--disable-shared --datadir="${DIR}" && \
make -j && \
make install && \
make distclean && \
rm -rf ${DIR} && \
DIR=$(mktemp -d) && cd ${DIR} && \
#@ libtheora http://www.theora.org/
curl -sL http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.bz2 | \
tar -jx --strip-components=1 && \
./configure --prefix="${SRC}" --with-ogg="${SRC}" --bindir="${SRC}/bin" \
--disable-shared --datadir="${DIR}" && \
make -j && \
make install && \
make distclean && \
rm -rf ${DIR} && \
DIR=$(mktemp -d) && cd ${DIR} && \
## libvpx https://www.webmproject.org/code/
curl -sL https://codeload.github.com/webmproject/libvpx/tar.gz/v${VPX_VERSION} | \
tar -zx --strip-components=1 && \
./configure --prefix="${SRC}" --enable-vp8 --enable-vp9 --disable-examples --disable-docs && \
make -j && \
make install && \
make clean && \
rm -rf ${DIR} && \
DIR=$(mktemp -d) && cd ${DIR} && \
## libmp3lame http://lame.sourceforge.net/
curl -sL https://downloads.sf.net/project/lame/lame/${LAME_VERSION%.*}/lame-${LAME_VERSION}.tar.gz | \
tar -zx --strip-components=1 && \
./configure --prefix="${SRC}" --bindir="${SRC}/bin" --disable-shared --enable-nasm --datadir="${DIR}" && \
make -j && \
make install && \
make distclean&& \
rm -rf ${DIR} && \
DIR=$(mktemp -d) && cd ${DIR} && \
## xvid https://www.xvid.com/
curl -sL http://downloads.xvid.org/downloads/xvidcore-${XVID_VERSION}.tar.gz | \
tar -zx && \
cd xvidcore/build/generic && \
./configure --prefix="${SRC}" --bindir="${SRC}/bin" --datadir="${DIR}" && \
make -j && \
make install && \
rm -rf ${DIR} && \
DIR=$(mktemp -d) && cd ${DIR} && \
## fdk-aac https://github.com/mstorsjo/fdk-aac
curl -sL https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz | \
tar -zx --strip-components=1 && \
autoreconf -fiv && \
./configure --prefix="${SRC}" --disable-shared --datadir="${DIR}" && \
make -j && \
make install && \
make distclean && \
rm -rf ${DIR} && \
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
          --enable-libfdk_aac \
          --enable-libmp3lame \
          --enable-libopus \
          --enable-libtheora \
          --enable-libvorbis \
          --enable-libvpx \
          --enable-libx264 \
          --enable-libx265 \
          --enable-libxvid \
          --enable-gpl \
          --enable-avresample \
          --enable-postproc \
          --enable-nonfree \
          --disable-debug \
          --enable-small \
          --enable-openssl && \
make -j && \
make install && \
make distclean && \
hash -r && \
rm -rf ${DIR} &&
ldconfig -v &&
ffmpeg -buildconf
