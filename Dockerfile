FROM debian:stable-slim

MAINTAINER Manfred Touron "m@42.am"

ENV DEBIAN_FRONTEND=noninteractive

# Instalacija potrebnih paketa
RUN apt-get -qq -y update && \
    apt-get -qq -y full-upgrade && \
    apt-get -qq -y install --no-install-recommends icecast2 python3-setuptools sudo && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/log/icecast2 && \
    touch /var/log/icecast2/access.log && \
    touch /var/log/icecast2/error.log && \
    chown -R icecast2 /etc/icecast2 && \
    chmod 777 /var/log/icecast2/access.log && \
    chmod 777 /var/log/icecast2/error.log && \
    sed -i 's/ -d//' /etc/cron-apt/action.d/3-download || true

# Postavljanje korisnika icecast2 kao default korisnika za pokretanje naredbi
USER icecast2

# Kopiramo start.sh skriptu i osiguravamo da je izvršna
COPY start.sh /start.sh
RUN chmod 755 /start.sh

# Kopiramo prilagođeni icecast.xml u odgovarajući direktorijum
COPY etc/icecast2/icecast.xml /etc/icecast2/icecast.xml

# Definišemo ulaznu tačku i port
CMD ["/start.sh"]
EXPOSE 8000

# Volumes za konfiguraciju i logove
VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]
