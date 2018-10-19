FROM alpine

ARG GITHUB="https://github.com/z3APA3A/3proxy.git"
ARG BRANCH="0.8.12"

RUN \
    set -ex && \
    apk add --no-cache --virtual .build-deps \
    git \
    gcc \
    linux-headers \
    make \
    musl-dev \
    tar \
    openssl

WORKDIR /opt

RUN \
  git clone ${GITHUB} \
  && cd /opt/3proxy \
  && git checkout ${BRANCH} \
  && echo '#define ANONYMOUS 1' >> /opt/3proxy/src/3proxy.h \
  && make -f Makefile.Linux \
  && apk del .build-deps

# Not working, will pass it as CMD
# ENTRYPOINT '/opt/3proxy/src/3proxy'
