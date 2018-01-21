#!/bin/sh
FILE=connectd_1.3-08h_armhf_BETA
tar xvzf $FILE.gz
rm $FILE.gz
PWD=$(pwd)
sed -i "/^BASEDIR=/c\BASEDIR=$PWD" usr/bin/connectd_options
sed -i "/^BASEDIR=/c\BASEDIR=$PWD" usr/bin/connectd_control
sed -i "/^BASEDIR=/c\BASEDIR=$PWD" usr/bin/connectd_start
sed -i "/^BASEDIR=/c\BASEDIR=$PWD" usr/bin/connectd_installer_deprecated
sed -i "/^BASEDIR=/c\BASEDIR=$PWD" usr/bin/connectd_register_deprecated
sed -i "/^BASEDIR=/c\BASEDIR=$PWD" etc/init.d/connectd
sed -i "/^BASEDIR=/c\BASEDIR=$PWD" etc/init.d/connectd_schannel
