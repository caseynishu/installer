#!/bin/bash
# Weaved, Inc. Service uninstaller for Intel CAP.
# Tested on December 18, 2015 Ubuntu Linux release
# This automatically uninstalls daemons for http on port 80,
# http on port 8080, and SSH on port 22, along with notification scripts.

TMP_DIR=/tmp

printf "Weaved connection installer Version: %s \n" "$VERSION"
# check for sudo user at this point
if [[ $EUID -ne 0 ]]; then
        echo "Running uninstall.sh requires root access." 1>&2
        echo "Please run sudo ./uninstall.sh." 1>&2
	exit 1
fi

echo Weaved Uninstaller for Intel CAP will now remove services for:
echo - http on port 80
echo - http on port 8080
echo - SSH on port 22
echo "Do you wish to continue? (Y/N)"
read word
case $word in
        [Yy]* )
                echo Removing Weaved software...
                ;;
        [Nn]* )
                echo Exiting...
                exit
                ;;
        * )
                echo Exiting...
                exit
                ;;
esac

weavedStop.sh

rm /usr/bin/weavedConnectd.linux
rm /usr/bin/weavedStop.sh
rm /usr/bin/weavedStart.sh
rm /usr/bin/Weavedssh22.sh
rm /usr/bin/Weavedhttp80.sh
rm /usr/bin/Weavedhttp8080.sh

rm -rf /etc/weaved

crontab -l | grep -v weavedStart.sh | cat > $TMP_DIR/.crontmp
crontab $TMP_DIR/.crontmp
echo
echo "If you uninstalled Weaved connectd without deleting Device Connections first,"
echo "there may be orphaned Device Connections in your Device List.  Use the "
echo "'Settings' link in the web portal Device List to delete these."
 
