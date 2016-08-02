#!/bin/sh
# sgwd.sh
# allows quick editing of the Weaved Debian control files and maintainer
# scripts on Ubuntu system and removing backup file to avoid warning/error

DIR=/DEBIAN
pkg=remot3it
version=1.3-07
arch=armhf
packageName="$pkg"_"$version"_"$arch"

sudo gedit "$packageName"$DIR/control "$packageName"$DIR/prerm "$packageName"$DIR/postrm "$packageName"$DIR/postinst "$packageName"$DIR/conffiles
sudo rm "$packageName"$DIR/*~

