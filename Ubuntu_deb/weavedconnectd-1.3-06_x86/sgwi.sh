#!/bin/sh
# sgwi.sh
# allows quick editing of the Weaved installer script on Ubuntu
# system and removing backup file to avoid warning/error
BINDIR=/usr/bin

packageName=weavedconnectd-1.3-06_x86
sudo gedit "$packageName"$BINDIR/weavedinstaller "$packageName"$BINDIR/weavedinstaller_OEM "$packageName"$BINDIR/weavedinstallerlib "$packageName"$BINDIR/weavedfactoryreset
sudo rm "$packageName"$BINDIR/*~

