#!/bin/bash

# Ažuriramo konfiguracioni fajl sa odgovarajućim vrednostima
sed -i "s/<hostname>[^<]*<\/hostname>/<hostname>${ICECAST_HOSTNAME}<\/hostname>/g" /etc/icecast2/icecast.xml
sed -i "s/<source-password>[^<]*<\/source-password>/<source-password>${ICECAST_SOURCE_PASSWORD}<\/source-password>/g" /etc/icecast2/icecast.xml
sed -i "s/<relay-password>[^<]*<\/relay-password>/<relay-password>${ICECAST_RELAY_PASSWORD}<\/relay-password>/g" /etc/icecast2/icecast.xml
sed -i "s/<admin-password>[^<]*<\/admin-password>/<admin-password>${ICECAST_ADMIN_PASSWORD}<\/admin-password>/g" /etc/icecast2/icecast.xml

# Pokrećemo Icecast server
exec sudo -Eu icecast2 icecast2 -n -c /etc/icecast2/icecast.xml
