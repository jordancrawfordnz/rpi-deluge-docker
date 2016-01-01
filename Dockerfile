# Sets up a Deluge server and web client.

FROM resin/rpi-raspbian:jessie

MAINTAINER Jordan Crawford <jordan.crawford@me.com>

# Setup deluged, deluge-web and deluge-console.
RUN apt-get update; apt-get install deluged deluge-web deluge-console -y

RUN apt-get install nano -y

# Setup default Deluge config with remote access enabled and an external access username and password.
# Setup default download directory's to the provided volume.
# TODO: What permissions for configuration?

# Expose the deluge control port and the web UI port.
EXPOSE 58846 8112

# Add the start script.
ADD start.sh /root/start.sh

# Run the start script on boot.
#CMD ["/root/start.sh"]

