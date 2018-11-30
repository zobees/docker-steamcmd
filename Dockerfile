FROM ubuntu:16.04

LABEL MAINTAINER cliffrowley@gmail.com

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
      ca-certificates apt-utils software-properties-common
RUN echo steam steam/question select "I AGREE" | debconf-set-selections
RUN echo steam steam/license note '' | debconf-set-selections
RUN add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y --no-install-recommends \
      lib32gcc1 steamcmd && \
    ln -sf /usr/games/steamcmd /usr/bin/steamcmd

RUN DEBIAN_FRONTEND=noninteractive apt-get purge -y \
      apt-utils software-properties-common && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y

RUN steamcmd +quit
