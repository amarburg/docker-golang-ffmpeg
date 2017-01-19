FROM golang:1.8-wheezy

### From https://hub.docker.com/r/jrottenberg/ffmpeg/
#ENV         FFMPEG_VERSION=3.2.2 \
#            FAAC_VERSION=1.28    \
#            FDKAAC_VERSION=0.1.4 \
#            LAME_VERSION=3.99.5  \
#            OGG_VERSION=1.3.2    \
#            OPUS_VERSION=1.1.1   \
#            THEORA_VERSION=1.1.1 \
#            YASM_VERSION=1.3.0   \
#            VORBIS_VERSION=1.3.5 \
#            VPX_VERSION=1.6.0    \
#            XVID_VERSION=1.3.4   \
#            X265_VERSION=2.0     \
#            X264_VERSION=20160826-2245-stable \
#            PKG_CONFIG_PATH=/usr/local/lib/pkgconfig \
#            SRC=/usr/local

RUN      buildDeps="autoconf \
                    automake \
                    apt-utils \
                    cmake \
                    curl \
                    bzip2 \
                    g++ \
                    gcc \
                    git \
                    libtool \
                    make \
                    nasm \
                    perl \
                    pkg-config \
                    python \
                    libssl-dev \
                    zlib1g-dev" && \
        export MAKEFLAGS="-j$(($(nproc) + 1))" && \
        apt-get -yqq update && \
        apt-get install -yq --no-install-recommends ${buildDeps} ca-certificates
RUN ./build_ffmpeg.sh

RUN    cd && \
       apt-get autoremove -y && \
       apt-get clean -y && \
       rm -rf /var/lib/apt/lists && \
       ffmpeg -buildconf
