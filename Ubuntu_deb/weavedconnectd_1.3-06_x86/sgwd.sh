#!/bin/sh
# sgwd.sh
# allows quick editing of the Weaved Debian control files and maintainer
# scripts on Ubuntu system and removing backup file to avoid warning/error

DIR=/DEBIAN
packageName=weavedconnectd_1.3-06_x86

sudo gedit "$packageName"$DIR/control "$packageName"$DIR/prerm "$packageName"$DIR/postrm "$packageName"$DIR/postinst "$packageName"$DIR/conffiles
sudo rm "$packageName"$DIR/*~

