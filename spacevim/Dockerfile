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
        fd-find \
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

# neovim deps
RUN pip3 install --system neovim pipenv \
    && pip2 install neovim \
    && gem install --no-user-install neovim \
    && npm install --global neovim

# update container's user IDs to match docker host user
ARG HOST_UID
ARG HOST_GID
RUN if [ -n "$HOST_UID" ] ; then usermod --uid $HOST_UID linuxbrew ; fi \
    && if [ -n "$HOST_GID" ] ; then groupmod --gid $HOST_GID linuxbrew ; fi

USER linuxbrew

ENV PATH=/home/linuxbrew/.local/bin:/home/linuxbrew/.cargo/bin:/home/linuxbrew/go/bin:/home/linuxbrew/.gems/bin:$PATH

# neovim
RUN brew install nvim \
    && brew cleanup -s

# lsp
RUN go get -u golang.org/x/tools/gopls \
    && solargraph download-core

# spacevim
RUN git clone https://github.com/SpaceVim/SpaceVim.git $HOME/.SpaceVim \
    && mkdir -p $HOME/.config $HOME/.SpaceVim.d \
    && cp $HOME/.SpaceVim/docker/init.toml $HOME/.SpaceVim.d/init.toml \
    && sed -i -r -e 's/(\[options\])/\1\n    disabled_plugins = ["deoplete-go","vnote","julia-vim"]/' \
                    $HOME/.SpaceVim.d/init.toml \
    && pip3 install sexpdata websocket-client \
    && $HOME/.SpaceVim/docs/install.sh \
    && mkdir -p $HOME/.vim/files/info \
    && (cd $HOME/.SpaceVim/bundle/vimproc.vim/ && make) \
    && nvim --headless +'call dein#install()' +qall \
    && rm -f $HOME/.SpaceVim.d/init.toml

# TODO: re-enable disabled_plugins when respecive issues have been fixed upstream:
#
# deoplete-go
#  Hangs at:
#    x86_64-linux-gnu-gcc -pthread -Wno-unused-result -Wsign-compare -DNDEBUG -g -fwrapv -O2 -Wall -g -fstack-protector-strong -Wformat -Werror=format-security -g -fwrapv -O2 -g -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -fPIC -I./python -I./lib -I/usr/include/python3.8 -c ./python/objToJSON.c -o /home/linuxbrew/.cache/vimfiles/repos/github.com/zchee/deoplete-go/build/temp.linux-x86_64-3.8/./python/objToJSON.o -D_GNU_SOURCE
#
#  See also:
#    https://github.com/SpaceVim/SpaceVim/issues/3380
#    https://github.com/deoplete-plugins/deoplete-go/issues/98
#    https://github.com/Shougo/deoplete.nvim/issues/546
#
# vnote
#   Error detected while processing function vnote#OnVimLeave[1]..vnote#GetNoteBook:
#   line    2:
#   E171: Missing :endif
#
# julia-vim
#   Unknown function: LaTeXtoUnicode#Refresh

ENTRYPOINT ["nvim"]
