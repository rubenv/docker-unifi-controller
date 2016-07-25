FROM debian

RUN echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" > "/etc/apt/sources.list.d/100-ubnt.list" && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    apt-get update && \
    apt-get install --no-install-recommends -qy unifi && \
    apt-get -q clean && rm -rf /var/lib/apt/lists/* && \
    useradd -d /var/lib/unifi unifi && \
    mkdir -p /var/lib/unifi /var/log/unifi /var/run/unifi && \
    chown -R unifi:unifi /usr/lib/unifi /var/lib/unifi /var/log/unifi /var/run/unifi && \
    ln -s /var/lib/unifi /usr/lib/unifi/data

USER unifi
WORKDIR /var/lib/unifi

EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp
VOLUME ["/var/lib/unifi"]
