FROM golang:1.9-stretch

COPY build_ffmpeg.sh /root

ENV BUILDDEPS="autoconf \
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
                    zlib1g-dev"

#ENV MAKEFLAGS="-j$(($(nproc) + 1))"

RUN     apt-get -yqq update && \
        apt-get install -yq --no-install-recommends ${BUILDDEPS} ca-certificates && \
        /root/build_ffmpeg.sh && \
       apt-get autoremove -y && \
       apt-get clean -y && \
       rm -rf /var/lib/apt/lists && \
       ffmpeg -buildconf
