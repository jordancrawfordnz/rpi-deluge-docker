# Sets up a Deluge server and web client.

FROM resin/rpi-raspbian:jessie

MAINTAINER Jordan Crawford <jordan.crawford@me.com>

# Setup deluged, deluge-web and deluge-console.
RUN apt-get update; apt-get install deluged deluge-web deluge-console -y

# Expose the deluge control port and the web UI port.
EXPOSE 58846 8112

# Add the start script.
ADD start.sh /root/start.sh

# Run the start script on boot.
CMD ["/root/start.sh"]
