#!/bin/bash
# weavedstop.sh - stop all weaved/remot3.it services
# May 24, 2016

/etc/init.d/weaved stop
/etc/init.d/weaved.schannel stop

