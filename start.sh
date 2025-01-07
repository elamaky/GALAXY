#!/bin/sh

env

set -x

set_val() {
    if [ -n "$2" ]; then
        echo "set '$2' to '$1'"
        sed -i "s/<$2>[^<]*<\/$2>/<$2>$1<\/$2>/g" /etc/icecast2/icecast.xml
    else
        echo "Setting for '$1' is missing, skipping." >&2
    fi
}

set_val $ICECAST_SOURCE_PASSWORD source-galaxy
set_val $ICECAST_RELAY_PASSWORD  relay-galaxy
set_val $ICECAST_ADMIN_PASSWORD  admin-galaxy
set_val $ICECAST_PASSWORD        galaxy
set_val $ICECAST_HOSTNAME        https://galaxy-mn11.onrender.com

set -e

sudo -Eu icecast2 icecast2 -n -c /etc/icecast2/icecast.xml

# Pokrećemo Icecast server
exec sudo -Eu icecast2 icecast2 -n -c /etc/icecast2/icecast.xml
