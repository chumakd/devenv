FROM ubuntu:20.04 as fetcher
ARG  CLANG_RELEASE=11.0.0

ADD https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANG_RELEASE}/clang+llvm-${CLANG_RELEASE}-x86_64-linux-gnu-ubuntu-20.04.tar.xz.sig .
ADD https://github.com/llvm/llvm-project/releases/download/llvmorg-${CLANG_RELEASE}/clang+llvm-${CLANG_RELEASE}-x86_64-linux-gnu-ubuntu-20.04.tar.xz .

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update \
    && apt-get -y install gpg xz-utils
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys B6C8F98282B944E3B0D5C2530FC3042E345AD05D \
    && gpg --verify clang+llvm-${CLANG_RELEASE}-x86_64-linux-gnu-ubuntu-20.04.tar.xz.sig
RUN tar -xf clang+llvm-${CLANG_RELEASE}-x86_64-linux-gnu-ubuntu-20.04.tar.xz


FROM ubuntu:20.04
ARG  CLANG_RELEASE=11.0.0

COPY --from=fetcher /clang+llvm-${CLANG_RELEASE}-x86_64-linux-gnu-ubuntu-20.04/ /usr/local/

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update \
    && apt-get -y install build-essential cmake
