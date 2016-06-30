#!/bin/bash

# weavedStop.sh, stops all running Weaved services

for f in /usr/bin/Weaved*.sh; do
	$f stop
done
weavedschannel stop
