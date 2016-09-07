#!/bin/sh
# sgwe.sh
# allows quick editing of the Weaved Debian control files and maintainer
# scripts on Ubuntu system and removing backup file to avoid warning/error

DIR=/etc/init.d
packageName=weavedconnectd_1.3-07_x86

sudo gedit "$packageName"$DIR/weaved "$packageName"$DIR/weaved.schannel 
sudo rm "$packageName"$DIR/*~

