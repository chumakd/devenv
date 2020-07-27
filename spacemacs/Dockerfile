FROM linuxbrew/brew

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US \
    LANG=en_US.UTF-8

# distro deps
RUN apt-get update \
    && apt-get -y install \
        build-essential \
        clang \
        clangd \
        cmake \
        cscope \
        exuberant-ctags \
        fontconfig \
        global \
        golang \
        npm \
        openjdk-11-jdk-headless \
        pkg-config \
        python2 \
        python3-pip \
        ruby \
        ruby-dev \
        xfonts-utils \
        yarnpkg \
    && apt-get clean all

# python2-pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python2

# spacemacs deps
RUN npm install --global tern

# update container's user IDs to match docker host user
ARG HOST_UID
ARG HOST_GID
RUN if [ -n "$HOST_UID" ] ; then usermod --uid $HOST_UID linuxbrew ; fi \
    && if [ -n "$HOST_GID" ] ; then groupmod --gid $HOST_GID linuxbrew ; fi

# TODO: when new stable version of Emacs is released, most likely it won't be
# available in default Ubuntu repos, so it needs to be built, for which `brew`
# can be used, but Emacs cannot be built in a Docker "build" container, i.e. as
# part of `docker build` process, so an acceptable workaround needs to be found
# before then:
#
#   https://www.gnu.org/software/emacs/manual/html_node/elisp/Building-Emacs.html
#   https://emacs.stackexchange.com/questions/22665/building-emacs-in-a-docker-container
#
# For the time being, Emacs 26.3 is installed from Ubuntu 20.04 repos
#
RUN apt-get -y install emacs \
    && apt-get clean all

USER linuxbrew

# emacs
#RUN brew install emacs \
#    && brew cleanup -s

# spacemacs
RUN git clone https://github.com/syl20bnr/spacemacs $HOME/.emacs.d

ENTRYPOINT ["emacs"]