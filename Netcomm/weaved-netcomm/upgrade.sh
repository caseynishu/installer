#!/bin/sh
/etc/init.d/rc.d/weavedSSH stop
/etc/init.d/rc.d/weavedSCH stop
/etc/init.d/rc.d/weavedWEB stop
/etc/init.d/rc.d/weavedRMT3 stop
wget https://github.com/weaved/installer/raw/master/Netcomm/netcomm.tgz -O /root/netcomm.tgz
cd /root
tar xvzf netcomm.tgz
cd weaved-netcomm
chmod +x install
./install
