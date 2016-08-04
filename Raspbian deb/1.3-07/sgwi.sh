#!/bin/sh
# sgwi.sh
# allows quick editing of the Weaved installer script on Ubuntu
# system and removing backup file to avoid warning/error
BINDIR=/usr/bin
packageName=weavedconnectd_1.3-07

sudo gedit "$packageName"$BINDIR/weavedinstaller "$packageName"$BINDIR/remot3it_register "$packageName"$BINDIR/weavedlibrary "$packageName"$BINDIR/weavedfactoryreset "$packageName"$BINDIR/remot3it_migrate_from_weaved
sudo rm "$packageName"$BINDIR/*~

