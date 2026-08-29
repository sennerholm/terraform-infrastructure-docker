FROM ubuntu:24.04

# renovate: datasource=github-releases depName=coder/code-server
ARG CODE_SERVER_VERSION=4.135.0

RUN apt-get update && apt-get install -y \
        curl \
        git \
        sudo \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb" \
        -o /tmp/code-server.deb \
    && dpkg -i /tmp/code-server.deb \
    && rm /tmp/code-server.deb

RUN useradd -m -s /bin/bash coder \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/coder

USER coder
WORKDIR /home/coder
