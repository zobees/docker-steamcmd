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

ENV GOSU_VERSION="1.10"
RUN set -ex; \
	fetchDeps='wget'; \
	apt-get update; \
	apt-get install -y --no-install-recommends $fetchDeps; \
	rm -rf /var/lib/apt/lists/*; \
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	chmod +x /usr/local/bin/gosu; \
	gosu nobody true; \
	apt-get purge -y --auto-remove $fetchDeps

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
