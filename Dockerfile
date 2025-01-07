FROM debian:stable-slim

MAINTAINER Manfred Touron "m@42.am"

ENV DEBIAN_FRONTEND noninteractive
ENV ICECAST_HOSTNAME galaxy-mn11.onrender.com

RUN apt-get -qq -y update && \
    apt-get -qq -y full-upgrade && \
    apt-get -qq -y install icecast2 python3-setuptools sudo && \
    apt-get -y autoclean && \
    apt-get clean && \
    # Kreiramo potrebne direktorijume i fajlove za logove
    mkdir -p /var/log/icecast2 && \
    touch /var/log/icecast2/access.log && \
    touch /var/log/icecast2/error.log && \
    chown -R icecast2 /etc/icecast2 && \
    chmod 777 /var/log/icecast2/access.log && \
    chmod 777 /var/log/icecast2/error.log && \
    sed -i 's/ -d//' /etc/cron-apt/action.d/3-download || true

# Kopiramo start.sh skriptu i osiguravamo da je izvršna
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
EXPOSE 8000
VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]
