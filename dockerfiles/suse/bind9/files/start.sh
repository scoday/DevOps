#!/bin/sh
#

start_named_foreground() {
    /usr/sbin/named -f -c /var/lib/named/etc/named.conf.local 
}

start_named_foreground
