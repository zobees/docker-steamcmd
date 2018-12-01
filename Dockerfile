FROM zobees/steamcmd-base

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends gosu && \
    rm -rf /var/lib/apt/lists/*

RUN addgroup --gid 1000 steam && \
    adduser --system --home /home/steam --shell /bin/false --uid 1000 --ingroup steam steam && \
    mkdir -m 777 /data && \
    chown steam:steam /data /home/steam

ADD steamcmd-* /usr/local/bin/
RUN chmod +x /usr/local/bin/steamcmd-*

ENV UID=1000 GID=1000

ENTRYPOINT ["/usr/local/bin/steamcmd-entrypoint"]

CMD ["true"]

LABEL maintainer cliffrowley@gmail.com
