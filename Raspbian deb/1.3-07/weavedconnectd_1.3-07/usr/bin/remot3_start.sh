#!/bin/bash
#
#  Remot3 it startup script
#
#  Weaved Inc : www.weaved.com
#
#

# include shell script lib, must be in path or specify path here
source /usr/bin/remot3_wlib.sh

#### Settings #####
VERSION=0.0.2
MODIFIED="June 2, 2016"
#
# Config 
#mac
WEAVED_DIR="/etc/weaved"
LOG_NAME="remot3_startup"
VERBOSE=0


update_software_versions()
{
    logger "[$LOG_NAME] Update Versions"
    # Update Version Numbers if needed
    # first check package and see if we need to update weaved software version info
    info=$(remot3_control.sh updatedeb weavedconnectd)
    logger "[$LOG_NAME] $info"
    # update firmware version info
    fwver=$(mpd-get-fwversion | awk -F ":" '{ print $2 }')
    info=$(remot3_control.sh update system_firmware "$fwver")
    logger "[$LOG_NAME] $info"
    return 0
}

do_provision()
{
    logger "[$LOG_NAME] Call Provision"
    # do bulk provisioning
    info=$(remot3_control.sh bprovision all)
    ret="$?"
    logger [$LOG_NAME] $info
    return $ret
}


internet_available()
{
    ret=0
    nc -z api.weaved.com 80  >/dev/null 2>&1
    online=$?
    if [ $online -eq 0 ]; then
        if [ $VERBOSE -gt 0 ]; then
            echo "Internet Available"
        fi
        ret=1
    else
        if [ $VERBOSE -gt 0 ]; then
            echo "Internet Not Available"
        fi
    fi
    return $ret
}


###################################################
# Main Loop, wait for internet access             #  
###################################################

logger "[$LOG_NAME] Startup"

while [ 1 ]
do
    internet_available
    if [ "$?" -eq 1 ]; then
        # internet is available, try provision
        sleep 5
        do_provision
        #
        if [ "$?" -eq 0 ]; then
            #need restart of schannel
            /etc/init.d/weaved.schannel restart
        fi
        update_software_versions
        #
        break
    fi 
    sleep 15
    logger "[$LOG_NAME] Loop"
done
logger "[$LOG_NAME] exit"

exit 0


