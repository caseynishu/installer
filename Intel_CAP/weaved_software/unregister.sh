#! /bin/sh
VERSION="WeavedIntel CAP unregister.sh version 1.00"

printf "Version: %s \n" "$VERSION"
# check for sudo user at this point
if [[ $EUID -ne 0 ]]; then
	echo "Running unregister.sh requires root access." 1>&2
        echo "Please run sudo ./unregister.sh." 1>&2
        exit 1
fi

weavedStop.sh
# restore the blank default enablement/configuration files
cp *.conf /etc/weaved/services/
ls -l /etc/weaved/services
sync

