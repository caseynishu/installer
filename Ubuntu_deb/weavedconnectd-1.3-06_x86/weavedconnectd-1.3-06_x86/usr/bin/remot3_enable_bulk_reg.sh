#!/bin/sh
#----- remot3_enable_bulk_reg.sh
# May 24, 2016
# enables bulk registration, assuming that desired enablement files are in /etc/weaved/pfiles
#---------------------
update-rc.d weaved defaults 99 10
update-rc.d weaved.schannel defaults 99 10

