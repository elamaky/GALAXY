#!/bin/sh

# Prikazivanje svih promenljivih okruženja
env

# Omogućavanje režima za praćenje izvršavanja skripte
set -x

# Funkcija za postavljanje vrednosti u icecast.xml
set_val() {
    if [ -n "$1" ]; then
        echo "set '$2' to '$1'"
        # Ažuriranje vrednosti u icecast.xml koristeći sed
        sed -i "s|<$2>[^<]*</$2>|<$2>$1</$2>|g" /etc/icecast2/icecast.xml
    else
        echo "Setting for '$2' is missing, skipping." >&2
    fi
}

# Postavljanje vrednosti za Icecast konfiguraciju
set_val "$ICECAST_SOURCE_PASSWORD" source-password
set_val "$ICECAST_RELAY_PASSWORD" relay-password
set_val "$ICECAST_ADMIN_PASSWORD" admin-password
set_val "$ICECAST_PASSWORD" password
set_val "$ICECAST_HOSTNAME" hostname

# Zaustavljanje skripte u slučaju greške
set -e

# Pokretanje Icecast servera bez sudo komande
icecast2 -n -c /etc/icecast2/icecast.xml

# Pokrećemo Icecast server
exec icecast2 -n -c /etc/icecast2/icecast.xml
