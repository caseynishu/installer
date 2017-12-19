#!/bin/bash
# Updated November 10, 2016

# weavedstop.sh, stops all running Weaved services

if [[ $EUID -ne 0 ]]; then
    echo "Running $0 requires root access." 1>&2
    echo "Please run sudo $0 instead of $0." 1>&2
    exit 1
fi


if [ -d "/usr/bin" ]; then
    for f in /usr/bin/Weaved*.sh; do
        if [ -f $f ]; then
	    $f stop
	fi
    done
fi

weavedschannel stop
