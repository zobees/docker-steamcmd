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

RUN useradd steam && \
    mkdir -p /home/steam/app && \
    mkdir -p /home/steam/steamcmd && \
    chown -R steam:steam /home/steam

ADD ./steam /home/steam

ENV STEAMCMD_URL="https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" \
    STEAMCMD_DIR="/home/steam/steamcmd" \
    STEAM_APP_DIR="/home/steam/app"

USER steam
WORKDIR /home/steam

CMD /home/steam/bin/init.sh
