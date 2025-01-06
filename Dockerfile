FROM debian:stable-slim

MAINTAINER Manfred Touron "m@42.am"

ENV DEBIAN_FRONTEND noninteractive
ENV ICECAST_HOSTNAME your_hostname_here

RUN apt-get -qq -y update
RUN apt-get -qq -y full-upgrade
RUN apt-get -qq -y install icecast2 python-setuptools sudo cron-apt
RUN apt-get -y autoclean
RUN apt-get clean
RUN chown -R icecast2 /etc/icecast2
RUN chmod 777 /var/log/icecast2/access.log
RUN chmod 777 /var/log/icecast2/error.log
RUN sed -i 's/ -d//' /etc/cron-apt/action.d/3-download

CMD ["/start.sh"]
EXPOSE 8000
VOLUME ["/config", "/var/log/icecast2", "/etc/icecast2"]

ADD ./start.sh /start.sh
ADD ./etc /etc
