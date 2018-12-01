FROM zobees/steamcmd-base

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends gosu && \
    rm -rf /var/lib/apt/lists/*

ADD steamcmd-entrypoint /usr/local/bin/steamcmd-entrypoint
ADD steamcmd-env /usr/local/bin/steamcmd-env
ADD steamcmd-run /usr/local/bin/steamcmd-run

ENTRYPOINT ["/usr/local/bin/steamcmd-entrypoint"]

CMD ["true"]

LABEL maintainer cliffrowley@gmail.com
