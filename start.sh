#!/bin/bash

# Ažuriramo konfiguracioni fajl sa odgovarajućim vrednostima
sed -i "s/<hostname>[^<]*<\/hostname>/<hostname>${ICECAST_HOSTNAME}<\/hostname>/g" /etc/icecast2/icecast.xml
sed -i "s/<source-password>[^<]*<\/source-password>/<source-password>galaxy<\/source-password>/g" /etc/icecast2/icecast.xml
sed -i "s/<relay-password>[^<]*<\/relay-password>/<relay-password>galaxy<\/relay-password>/g" /etc/icecast2/icecast.xml
sed -i "s/<admin-password>[^<]*<\/admin-password>/<admin-password>galaxy<\/admin-password>/g" /etc/icecast2/icecast.xml

# Pokrećemo Icecast server direktno bez sudo, kao icecast2 korisnik
exec icecast2 -n -c /etc/icecast2/icecast.xml
