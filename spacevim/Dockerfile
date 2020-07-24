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
        fontconfig \
        golang \
        npm \
        openjdk-11-jdk-headless \
        pkg-config \
        python3-pip \
        ruby \
        ruby-dev \
        xfonts-utils \
        yarnpkg \
    && apt-get clean all

# neovim
RUN brew install nvim \
    && brew cleanup -s \
    && pip3 install neovim pipenv \
    && gem install neovim

# spacevim
RUN git clone https://github.com/SpaceVim/SpaceVim.git $HOME/.SpaceVim \
    && mkdir -p $HOME/.config $HOME/.SpaceVim.d $HOME/.vim/files/info \
    && cp $HOME/.SpaceVim/docker/init.toml $HOME/.SpaceVim.d/init.toml \
    && sed -i -r -e 's/(\[options\])/\1\n    disabled_plugins = ["deoplete-go","vnote","LanguageClient-neovim","vim-import-js","floobits-neovim","julia-vim"]/' \
                    $HOME/.SpaceVim.d/init.toml \
    && pip3 install sexpdata websocket-client \
    && $HOME/.SpaceVim/docs/install.sh \
    && nvim --headless +'call dein#install()' +qall \
    && rm -f $HOME/.SpaceVim.d/init.toml
