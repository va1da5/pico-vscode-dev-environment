FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
ENV PICO_SDK_PATH=/pico/pico-sdk

WORKDIR /tmp

RUN apt update \
    && apt install -y minicom curl wget git gdb-multiarch cmake make pkgconf autoconf libreadline-dev tk-dev \
    build-essential libtool automake libftdi-dev libusb-1.0-0-dev gcc texinfo checkinstall \
    libssl-dev libsqlite3-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev \
    gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib \
    && apt -y clean \
    && apt -y autoremove \
    && rm -rf /var/lib/apt/lists/* \
    && curl -o Python-3.8.16.tgz https://www.python.org/ftp/python/3.8.16/Python-3.8.16.tgz \
    && tar xzf Python-3.8.16.tgz \
    && cd Python-3.8.16 \
    && ./configure --enable-optimizations \
    && make install \
    && cd .. \
    && rm -rf Python-3.8.16

RUN git clone --branch rp2040 --recursive --depth=1  https://github.com/raspberrypi/openocd.git  \
    && cd openocd \
    && ./bootstrap \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && rm -rf openocd

WORKDIR /pico

RUN git clone https://github.com/raspberrypi/pico-sdk.git pico-sdk \
    && cd pico-sdk \
    && git submodule update --init

RUN git clone https://github.com/raspberrypi/openocd.git openocd

WORKDIR /