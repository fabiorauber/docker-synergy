FROM ubuntu:18.04

MAINTAINER Fabio Rauber "fabiorauber@gmail.com"

RUN apt-get update && \
    apt-get install -y wget \
      libavahi-compat-libdnssd1 \
      libcurl3 \
      libqt5core5a \
      libqt5gui5 \
      libqt5network5 \
      libqt5widgets5 \
      libssl1.0.0 \
      libx11-6 \
      libxext6 \
      libxi6 \
      libxtst6 && \
    cd /tmp && \
    wget "https://binaries.symless.com/v1.9.1/synergy_1.9.1.stable~b327%2B2a0225c1_amd64.deb" && \
    dpkg -i synergy*.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/synergy && \
    echo "synergy:x:${uid}:${gid}:Synergy,,,:/home/synergy:/bin/bash" >> /etc/passwd && \
    echo "synergy:x:${uid}:" >> /etc/group && \
    chown ${uid}:${gid} -R /home/synergy

USER synergy
ENV HOME /home/synergy
CMD /usr/bin/synergy
