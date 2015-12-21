#!/bin/bash
# Weaved, Inc. Service installer for Intel CAP
# Tested on December 18, 2015 Ubuntu Linux release
# This automatically installs daemons for http on port 80
# and SSH on port 22, along with notification scripts.
# This needs to be used with the Weaved portal V22 or later
# registration feature.

VERSION="Weaved installer 1.01 for Intel CAP"
AUTHOR="Gary Worsham"
DATE="12/18/2105"
startupScripts=3
# set -x
################## Start Install ###################
installW()
{
echo Weaved Installer for Intel CAP will now install services for:
echo - http on port 80
echo - http on port 8080
echo - SSH on port 22
echo "Do you wish to continue? (Y/N)"
read word
case $word in
	[Yy]* )
		echo Installing...
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

if [ ! -f /usr/bin/weavedConnectd.linux ]; then
	cp weavedConnectd.linux /usr/bin
	chmod +x /usr/bin/weavedConnectd.linux 
fi

cp Weaved*.sh /usr/bin
cp weaved*.sh /usr/bin
chmod +x /usr/bin/weavedStop.sh
chmod +x /usr/bin/weavedStart.sh

# create folder for daemon provisioning files
if [ ! -d /etc/weaved ]; then 
	mkdir /etc/weaved
	if [ ! -d /etc/weaved/services ]; then 
		mkdir /etc/weaved/services
		cp *.conf /etc/weaved/services/
	fi
fi

# start all daemons
weavedStart.sh
}

################## end Install ###################

##### Version #####
displayVersion()
{
    printf "Version: %s \n" "$VERSION"
    # check for sudo user at this point
    if [[ $EUID -ne 0 ]]; then
        echo "Running install.sh requires root access." 1>&2
        echo "Please run sudo ./install.sh." 1>&2
	exit 1
    fi
}
##### End Version #####

######### Install Start Script to crontab #########
installStartCron()
{
    printf "."
    # crontab approach
    if [ $startupScripts = 3 ]; then
	checkCron=$(crontab -l 2> /dev/null | grep weavedStart.sh | wc -l)
	#       printf "CheckCron: $checkCron\n"
	if [ $checkCron = 0 ]; then
            crontab -l 2>/dev/null 1> "$TMP_DIR"/.crontab_old
            echo "@reboot /usr/bin/weavedStart.sh" >> "$TMP_DIR"/.crontab_old
            crontab "$TMP_DIR"/.crontab_old
	fi
    fi
}
######### End Start/Stop Scripts #########

main()
{
	displayVersion
	installW
	installStartCron
}

#=======================================
main
