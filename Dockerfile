# Sets up a Deluge server and web client.

FROM resin/rpi-raspbian:jessie
MAINTAINER Jordan Crawford <jordan@crawford.kiwi>

# Install required packages.
RUN apt-get update; apt-get install wget python python-twisted python-openssl python-setuptools intltool python-xdg python-chardet geoip-database python-libtorrent python-notify python-pygame python-glade2 librsvg2-common xdg-utils python-mako -y

# Setup a user.
RUN adduser --system -u 1000 deluge

# Clean up.
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Deluge version.
ARG DELUGE_VERSION=1.3.13

# Install Deluge.
WORKDIR /
RUN wget http://download.deluge-torrent.org/source/deluge-${DELUGE_VERSION}.tar.gz
RUN tar -zxvf deluge-${DELUGE_VERSION}.tar.gz
RUN rm deluge-${DELUGE_VERSION}.tar.gz
RUN cd deluge-${DELUGE_VERSION}; python setup.py build; python setup.py install

# Expose the deluge control port and the web UI port.
EXPOSE 58846 8112

# Setup volumes.
VOLUME /config
VOLUME /data

# Add the start script.
ADD start.sh /start.sh

# Run the start script on boot.
CMD ["/start.sh"]
