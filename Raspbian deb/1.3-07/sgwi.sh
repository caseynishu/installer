#!/bin/sh
# sgwi.sh
# allows quick editing of the Weaved installer script on Ubuntu
# system and removing backup file to avoid warning/error
BINDIR=/usr/bin
packageName=remot3it_1.3-07_armhf

sudo gedit "$packageName"$BINDIR/remot3itinstaller "$packageName"$BINDIR/remot3it_register "$packageName"$BINDIR/remot3itlibrary "$packageName"$BINDIR/remot3itfactoryreset "$packageName"$BINDIR/remot3_control.sh "$packageName"$BINDIR/remot3_enable_bulk_reg.sh "$packageName"$BINDIR/remot3it_migrate_from_weaved
sudo rm "$packageName"$BINDIR/*~

