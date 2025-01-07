#!/bin/sh

# Prikazivanje svih promenljivih okruženja
env

# Omogućavanje režima za praćenje izvršavanja skripte
set -x

# Funkcija za postavljanje vrednosti u icecast.xml
set_val() {
    if [ -n "$2" ]; then
        echo "set '$2' to '$1'"
        # Ažuriranje vrednosti u icecast.xml koristeći sed
        sed -i "s|<$2>[^<]*</$2>|<$2>$1</$2>|g" /etc/icecast2/icecast.xml
    else
        echo "Setting for '$1' is missing, skipping." >&2
    fi
}

# Postavljanje vrednosti za Icecast konfiguraciju
set_val "galaxy" source-password
set_val "galaxy" relay-password
set_val "angel" admin-password
set_val "galaxy" password
set_val "noise.example.com" hostname

# Zaustavljanje skripte u slučaju greške
set -e

# Pokretanje Icecast servera sa sudo i icecast2 korisnikom
exec sudo -Eu icecast2 icecast2 -n -c /etc/icecast2/icecast.xml

