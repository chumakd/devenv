FROM linuxbrew/brew

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US \
    LANG=en_US.UTF-8

# NOTE: rtags will pull in elpa-rtags package as "Recommends:" dependency,
#       which conflicts with Spacemacs, thus it needs to be installed w/o
#       recommends deps

# distro deps
RUN apt-get update \
    && apt-get -y install \
        ack-grep \
        aspell \
        autoconf \
        automake \
        build-essential \
        clang \
        clangd \
        cmake \
        cscope \
        exuberant-ctags \
        fontconfig \
        global \
        golang \
        graphviz \
        libgnutls28-dev \
        libjansson-dev \
        libncurses5-dev \
        libtool \
        libvterm-bin \
        libvterm-dev \
        libxml2-dev \
        npm \
        openjdk-11-jdk-headless \
        pkg-config \
        plantuml \
        python2 \
        python3-pip \
        ripgrep \
        ruby \
        ruby-dev \
        silversearcher-ag \
        texinfo \
        xfonts-utils \
        yarnpkg \
    && apt-get -y --no-install-recommends install \
        rtags \
    && apt-get clean all

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

# python2-pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python2

# rust+lsp
ADD https://sh.rustup.rs /usr/local/bin/rustup
RUN chmod +x /usr/local/bin/rustup \
    && RUSTUP_HOME=/usr/local CARGO_HOME=/usr/local \
       rustup -y --profile complete --default-toolchain stable

# lsp
RUN npm install --global \
        bash-language-server \
        dockerfile-language-server-nodejs \
        tern \
        typescript \
        typescript-language-server \
        vscode-css-languageserver-bin \
        vscode-html-languageserver-bin \
    && pip3 install --system 'python-language-server[all]' \
    && gem install --no-user-install solargraph

# update container's user IDs to match docker host user
ARG HOST_UID
ARG HOST_GID
RUN if [ -n "$HOST_UID" ] ; then usermod --uid $HOST_UID linuxbrew ; fi \
    && if [ -n "$HOST_GID" ] ; then groupmod --gid $HOST_GID linuxbrew ; fi

USER linuxbrew

ENV PATH=/home/linuxbrew/.local/bin:/home/linuxbrew/.cargo/bin:/home/linuxbrew/go/bin:/home/linuxbrew/.gems/bin:$PATH

# emacs
#   see TODO note about building emacs in docker above
#RUN brew install emacs \
#    && brew cleanup -s

# lsp
RUN go get -u golang.org/x/tools/gopls \
    && solargraph download-core

# spacemacs
RUN git clone -b develop https://github.com/syl20bnr/spacemacs $HOME/.emacs.d \
    && echo -e "\n\n\n\n\n" | emacs --batch --load $HOME/.emacs.d/init.el \
    && rm -f $HOME/.spacemacs

ENTRYPOINT ["emacs"]
