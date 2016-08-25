#!/bin/sh
# sgwd.sh
# allows quick editing of the Weaved Debian control files and maintainer
# scripts on Ubuntu system and removing backup file to avoid warning/error

DIR=/DEBIAN
packageName=weavedconnectd_1.3-07
LOGDIR=/usr/share/doc/weavedconnectd

sudo gunzip $packageName$LOGDIR/changelog.Debian.gz
sudo gedit "$packageName"$DIR/control "$packageName"$DIR/prerm "$packageName"$DIR/postrm "$packageName"$DIR/postinst "$packageName"$DIR/conffiles "$packageName""$LOGDIR"/changelog.Debian
sudo rm "$packageName"$DIR/*~
sudo rm "$packageName"$LOGDIR/*~
sudo gzip -9 -n "$packageName""$LOGDIR"/changelog.Debian

