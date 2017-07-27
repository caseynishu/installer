#!/bin/sh
# sgwi.sh
# allows quick editing of the Weaved installer script on Ubuntu
# system and removing backup file to avoid warning/error
BINDIR=/usr/bin
packageName=weavedconnectd_1.3-08

sudo gedit "$packageName"$BINDIR/remot3it_installer "$packageName"$BINDIR/remot3it_register "$packageName"$BINDIR/remot3it_library "$packageName"$BINDIR/remot3it_factoryreset "$packageName"$BINDIR/remot3it_control.sh "$packageName"$BINDIR/remot3it_enable_bulk_reg.sh "$packageName"$BINDIR/remot3it_migrate_from_weaved
sudo rm "$packageName"$BINDIR/*~

