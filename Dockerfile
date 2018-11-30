FROM zobees/steamcmd

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends gosu && \
    rm -rf /var/lib/apt/lists/*

ADD steamcmd-entrypoint /usr/bin/steamcmd-entrypoint
ADD steamcmd-run /usr/bin/steamcmd-run

ENTRYPOINT ["/usr/bin/steamcmd-entrypoint"]

CMD ["true"]

LABEL maintainer cliffrowley@gmail.com
