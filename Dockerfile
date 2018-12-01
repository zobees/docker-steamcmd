FROM zobees/steamcmd-base

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends gosu && \
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

CMD ["true"]

LABEL maintainer cliffrowley@gmail.com
