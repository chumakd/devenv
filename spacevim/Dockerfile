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

# neovim
RUN brew install nvim \
    && brew cleanup -s

# spacevim
RUN git clone https://github.com/SpaceVim/SpaceVim.git $HOME/.SpaceVim \
    && mkdir -p $HOME/.config $HOME/.SpaceVim.d \
    && cp $HOME/.SpaceVim/docker/init.toml $HOME/.SpaceVim.d/init.toml \
    && sed -i -r -e 's/(\[options\])/\1\n    disabled_plugins = ["deoplete-go","vnote","LanguageClient-neovim","vim-import-js","floobits-neovim","julia-vim"]/' \
                    $HOME/.SpaceVim.d/init.toml \
    && pip3 install sexpdata websocket-client \
    && $HOME/.SpaceVim/docs/install.sh \
    && mkdir -p $HOME/.vim/files/info \
    && (cd $HOME/.SpaceVim/bundle/vimproc.vim/ && make) \
    && nvim --headless +'call dein#install()' +qall \
    && rm -f $HOME/.SpaceVim.d/init.toml
