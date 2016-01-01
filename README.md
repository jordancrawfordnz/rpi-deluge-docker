### RPi Deluge Docker

#### What is Deluge?
Deluge is a torrent client. One of the best things about it is its highly client-server oriented, allowing you to remote control a deluge server from your desktop deluge app or using the web interface (deluge-web).

The Deluge website: http://deluge-torrent.org/

#### What does this image do?
- sets up deluged for remote access, default directories and gives a default username and password
- runs deluged and deluge-web

#### Tested On
- Raspberry Pi 2 running HypriotOS (should also work on the Raspberry Pi 1)

#### Getting Setup

##### Building
Pull the repository and run: ``docker build -t jordancrawford/rpi-deluge .``

##### Pulling from Docker Hub
An image is available at: https://hub.docker.com/r/jordancrawford/rpi-deluge/

Run ``docker pull jordancrawford/rpi-deluge`` to grab this copy.

##### Running
Use this command to run:
``docker run -d -v /home/pi/deluge/config:/config -v /home/pi/deluge/data:/data -p 58846:58846 -p 8112:8112 --name=deluge jordancrawford/rpi-deluge``

**Understanding the options**

- ``-d``: runs detached, so the Docker instance just runs in the background.

- ``-v /home/pi/deluge/config:/config``: sets up your host's ``/home/pi/deluge/config`` directory to map to the ``/config`` directory in the container. Docker will make this folder if it doesn't exist on your host system. This can be moved to anywhere on your host system, but the Docker image needs ``/config`` to exist! This is where you will go if you want to manually change any deluge configuration.

- ``-v /home/pi/deluge/data:/data``: similar to above, maps your host's ``/home/pi/deluge/data`` directory to map to the ``/data`` directory in the container. This is required and is where your files will be stored to by default.

- ``-p 58846:58846``: setups a port forwarding rule for the deluged port on 58846.

- ``-p 8112:8112``: setups a port forwarding rule for the deluge-web port on 8112.

The ``docker run`` documentation is very helpful, https://docs.docker.com/engine/reference/run/

**You should:**

- Change the default username and password in your config directory's auth file.

- Login to deluge-web and change the password (first login will prompt you to do this). The deluge-web password is independent from the deluged password.

#### Default Passwords
- remote access from a Deluge client:

Username: deluge

Password: deluge

- the deluge-web interface

Password: deluge

#### TODO
- Update to the latest deluge version
- Potentially allow more configuration options on run, such as defining the default username and password to use.