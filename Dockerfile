#OS used
FROM debian:9.6
ENV TERM dumb

# Install packages needed for ngtcp2
RUN rm -rf /var/lib/apt/lists/*  \
    && apt-get clean \
    && apt-get update --fix-missing         \
    && apt-get upgrade -y     \
    && apt-get install -y     \
    autoconf \ 
    automake \ 
    autotools-dev \ 
    libtool \
    libev4 \ 
    libev-dev \
    libssl-dev \
    pkg-config \
    libcunit1 \
    libcunit1-doc \
    libcunit1-dev \
    git \
    wget \
    unzip \
    zip \
    make \
    g++
    
RUN mkdir qlog

WORKDIR /qlog
#Clone and install openssl
RUN git clone --depth 1 -b quic-draft-15 https://github.com/tatsuhiro-t/openssl

WORKDIR /qlog/openssl

RUN ./config enable-tls1_3 --prefix=$PWD/build

RUN make -j$(nproc)

RUN make install_sw

RUN ./config

RUN make

RUN make install

RUN ldconfig -v

WORKDIR /qlog

# Download Robin's (qlog) ngtcp2
RUN wget https://quic.edm.uhasselt.be/files/ngtcp2_draft13_qlog.zip 

RUN unzip ngtcp2_draft13_qlog.zip

RUN rm -f ngtcp2_draft13_qlog.zip

WORKDIR /qlog/ngtcp2_draft13_qlog

# Build ngtcp2
RUN autoreconf -i 

RUN ./configure PKG_CONFIG_PATH=$PWD/../openssl/build/lib/pkgconfig LDFLAGS="-Wl,-rpath,$PWD/../openssl/build/lib" 

RUN make -j$(nproc) check

#RUN autoreconf -i

# install python dependencies for the scripts that are going to be used
#RUN pip install --upgrade pip
#RUN pip install apscheduler psutil

EXPOSE 4600/UDP

