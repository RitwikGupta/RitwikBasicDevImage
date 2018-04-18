FROM ubuntu:17.10

COPY .vimrc /root/.vimrc

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y --no-install-recommends install \
      ca-certificates \
      git-core \
      vim \
      curl \
      build-essential \
      libssl-dev \
      zlib1g-dev \
      libbz2-dev \
      libreadline-dev \
      libsqlite3-dev \
      wget \
      llvm \
      libncurses5-dev \
      libncursesw5-dev \
      xz-utils \
      tk-dev \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/

# Setup vim

RUN \
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

RUN \
  vim +PluginInstall +qall

WORKDIR /home/root

# Setup Python with pyenv
RUN git clone git://github.com/yyuu/pyenv.git .pyenv
ENV HOME /home/root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

COPY base-pip-reqs.txt /home/root/base-pip-reqs.txt

RUN \
  pyenv install 3.5.5 && \
  pyenv global 3.5.5

RUN \
  pip install -r base-pip-reqs.txt
