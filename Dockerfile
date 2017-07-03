FROM ubuntu:15.04
MAINTAINER cliffrowley@gmail.com

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
    apt-utils \
    ca-certificates \
    lib32gcc1 \
    net-tools \
    lib32stdc++6 \
    lib32z1 \
    lib32z1-dev \
    curl

ENV HOME="/home/steam" \
    PATH="$PATH:/home/steam/steamcmd"

RUN useradd steam && \
    mkdir -p $HOME/steamcmd && \
    chown -R steam:steam $HOME

USER steam

ENV STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    STEAMCMD_DIR="$HOME/steamcmd"

WORKDIR $HOME

RUN curl -s "$STEAMCMD_URL" | tar -v -C "$STEAMCMD_DIR" -zx
RUN $HOME/steamcmd/steamcmd.sh +quit
