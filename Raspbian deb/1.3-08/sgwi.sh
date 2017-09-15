#!/bin/sh
# sgwi.sh
# allows quick editing of the remot3.it connectd installer script on Ubuntu
# system and removing backup file to avoid warning/error
BINDIR=/usr/bin
packageName=connectd_1.3-08

sudo gedit "$packageName"$BINDIR/connectd_installer "$packageName"$BINDIR/connectd_register "$packageName"$BINDIR/connectd_library "$packageName"$BINDIR/connectd_factoryreset "$packageName"$BINDIR/connectd_control "$packageName"$BINDIR/connectd_enable_bulk_reg "$packagename"$BIN_DIR/OEM_OPTIONS
sudo rm "$packageName"$BINDIR/*~

