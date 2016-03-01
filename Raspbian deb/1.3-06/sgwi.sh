#!/bin/sh
# sgwi.sh
# allows quick editing of the Weaved installer script on Ubuntu
# system and removing backup file to avoid warning/error

packageName=weavedconnectd-1.3-06
sudo gedit "$packageName"/usr/bin/weavedinstaller "$packageName"/usr/bin/weavedinstaller_OEM "$packageName"/usr/bin/weavedinstallerlib
sudo rm "$packageName"/usr/bin/*~

