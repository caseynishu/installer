#!/bin/sh
#
# Weaved Image Updater for netcomm modems
#


#config
WEAVED_DIR="/etc/weaved"
PROVISION_DEFAULT="$WEAVED_DIR/pfiles"
DEVICES_ACTIVE="$WEAVED_DIR/active"
DEVICES_AVAILABLE="$WEAVED_DIR/available"
INIT_DIR="/etc/init.d/rc.d"


# shut all weaved services down
for file in $INIT_DIR/weav*
do                    
    eval "$file stop"
done


# grab latest netcomm weaved install

wget https://github.com/weaved/installer/raw/master/Netcomm/netcomm.tgz -O /root/netcomm.tgz --no-check-certificate
cd /root
tar xvzf netcomm.tgz
cd weaved-netcomm
chmod +x install
./install



# start every thing back up
for file in $INIT_DIR/weav*                         
do                                                  
    eval "$file start"                            
done  



