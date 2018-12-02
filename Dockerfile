FROM ubuntu:16.04

RUN echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    dpkg --add-architecture i386 && \
    apt-get -q -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
      lib32gcc1 steamcmd ca-certificates gosu && \
    ln -sf /usr/games/steamcmd /usr/bin/steamcmd && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -q -y && \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --gid 1000 steam && \
    adduser --system --home /home/steam --shell /bin/false --uid 1000 --ingroup steam steam && \
    usermod -a -G tty steam && \
    mkdir -m 777 /data && \
    chown steam:steam /data /home/steam

ADD entrypoint.sh /entrypoint.sh
ADD steamcmd-* /usr/local/bin/
RUN chmod +x /entrypoint.sh /usr/local/bin/steamcmd-*

ENV STEAMCMD_LOGIN=anonymous

ENTRYPOINT ["/entrypoint.sh"]

CMD ["steamcmd-wrapper", "true"]

LABEL maintainer cliffrowley@gmail.com
