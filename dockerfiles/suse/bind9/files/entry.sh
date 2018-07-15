#!/bin/bash
set -e

if [ "$1" = 'named' ]; then
    /usr/sbin/named -c "/var/lib/named/etc/named.conf.local"

    else echo "There is actually only one choice. (named)" "$@"
fi

exec "$@"
