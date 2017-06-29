#!/bin/sh
#----- remot3it_enable_bulk_reg.sh
# Version 1.01
# August 02, 2016
#
# enables bulk registration, assuming that desired enablement files are in /etc/remot3it/pfiles
#---------------------
update-rc.d remot3it defaults 99 10
update-rc.d remot3it.schannel defaults 99 10

