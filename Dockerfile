FROM golang:1.8-wheezy

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

COPY	build_ffmpeg.sh /root
RUN     /root/build_ffmpeg.sh

RUN    cd && \
       apt-get autoremove -y && \
       apt-get clean -y && \
       rm -rf /var/lib/apt/lists && \
       ffmpeg -buildconf
