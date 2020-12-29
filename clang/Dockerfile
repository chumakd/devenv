FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

RUN apt-get update \
    && apt-get install -y \
       apt-transport-https \
       ca-certificates \
       gpg

# GPG key for apt.llvm.org repo:
#   Sylvestre Ledru - Debian LLVM packages <sylvestre@debian.org>
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 15CF4D18AF4F7421

COPY llvm.list /etc/apt/sources.list.d/

RUN apt-get update \
    && apt-get install -y \
       build-essential \
       clang-11 \
       clangd-11 \
       cmake \
    && apt-get clean

RUN ln -s -t /usr/local/bin/ /usr/lib/llvm-11/bin/*
