#!/bin/sh
# sgwi.sh
# allows quick editing of the Weaved installer script on Ubuntu
# system and removing backup file to avoid warning/error
BINDIR=/usr/bin

packageName=weavedconnectd-1.3-06
sudo gedit "$packageName"$BINDIR/weavedinstaller "$packageName"$BINDIR/remot3it_register "$packageName"$BINDIR/weavedinstallerlib "$packageName"$BINDIR/weavedfactoryreset "$packageName"$BINDIR/remot3it_migrate_from_weaved
sudo rm "$packageName"$BINDIR/*~

