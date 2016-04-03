#!/bin/bash

CONFIGDIR=/config
DATADIR=/data

echo "Setting owner for config and data directories."
mkdir -p $CONFIGDIR
mkdir -p $DATADIR
chown -R deluge $CONFIGDIR
chown deluge $DATADIR

if [ ! -d $CONFIGDIR ]; then
        echo "The config directory does not exist! Please add it as a volume."
        exit 1
fi
if [ ! -d $DATADIR ]; then
        echo "The data directory does not exist! Please add it as a volume."
        exit 1
fi

# Check if the authentication file exists.
if [ ! -f $CONFIGDIR/auth ]; then
        AUTHMISSING=true
fi

if [ $AUTHMISSING ]; then
        echo "Doing initial setup."
        # Starting deluge
        deluged -c $CONFIGDIR

        # Wait until auth file created.
        while [ ! -f $CONFIGDIR/auth ]; do
                sleep 1
        done

        # allow remote access
        deluge-console -c $CONFIGDIR "config -s allow_remote True"

        # setup default paths to go to the user's defined data folder.
        deluge-console -c $CONFIGDIR "config -s download_location $DATADIR"
        deluge-console -c $CONFIGDIR "config -s torrentfiles_location $DATADIR"
        deluge-console -c $CONFIGDIR "config -s move_completed_path $DATADIR"
        deluge-console -c $CONFIGDIR "config -s autoadd_location $DATADIR"

        # Stop deluged.
        pkill deluged

        echo "Adding initial authentication details."
        echo deluge:deluge:10 >>  $CONFIGDIR/auth
fi

echo "Starting deluged and deluge-web."
su -s /bin/bash deluge -c 'deluged -c /config'
su -s /bin/bash deluge -c 'deluge-web -c /config'
