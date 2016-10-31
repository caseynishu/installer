#!/bin/bash
# Updated October 31, 2016

# weavedstop.sh, stops all running Weaved services

if [ -e /usr/bin/Weaved*.sh ]; then
    for f in /usr/bin/Weaved*.sh; do
	$f stop
    done
fi

weavedschannel stop
