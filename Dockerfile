FROM node:8.11.1-stretch

ENV PYTHON_VERSION 3.6.4

RUN set -ex \
  && apt-get -qq update \
  && apt-get -qq install -y --no-install-recommends \
    git gcc make \
    libyaml-dev zlib1g-dev libssl-dev libbz2-dev libreadline-dev \
    libfontconfig1-dev libx11-dev libxcomposite-dev \
    libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev \
    curl ca-certificates \
  \
  && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
  && apt-get -qq install git-lfs \
  \
  && mkdir -p /usr/local \
  && git clone https://github.com/tagomoris/xbuild.git /usr/local/xbuild \
  && /usr/local/xbuild/python-install -f $PYTHON_VERSION /usr/local/python \
  \
  && /usr/local/python/bin/pip3 install pip --upgrade \
  && /usr/local/python/bin/pip3 install wheel --upgrade \
  \
  && rm -rf /usr/local/xbuild \
  && apt-get -qq purge -y curl \
  && apt-get -qq autoremove -y \
  && apt-get -qq clean \
  && rm -rf ~/.cache/pip/ \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
