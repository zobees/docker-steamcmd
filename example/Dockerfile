FROM zobees/gse-steamcmd
MAINTAINER cliffrowley@gmail.com

USER root

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -q -y --no-install-recommends \
  telnet

USER steam

ENV STEAM_APP_ID="294420" \
    STEAM_APP_ANONYMOUS="1"

ENV SDTD_DIR="$STEAMCMD_DIR/7daystodie"

RUN mkdir -p $SDTD_DIR && steamcmd.sh +login anonymous \
    +force_install_dir $SDTD_DIR \
    +app_update $STEAM_APP_ID \
    +quit

CMD $SDTD_DIR/7DaysToDieServer.x86_64 \
  -logfile /dev/stdout \
  -configfile=$SDTD_DIR/serverconfig.xml \
  -quit \
  -batchmode \
  -nographics \
  -dedicated
