#!/bin/bash
# weavedstop.sh - stop all weaved/remot3.it services
# Version 1.0
# June 2, 2016

/etc/init.d/weaved stop
/etc/init.d/weaved.schannel stop

