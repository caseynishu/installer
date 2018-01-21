#!/bin/sh
tar xvzf connectd_1.3-08h_armhf_BETA.gz
rm connectd_1.3-08h_armhf_BETA.gz
PWD=$(pwd)
sed -i '/^BASEDIR=/c\BASEDIR="$PWD" usr/bin/connectd_options
sed -i '/^BASEDIR=/c\BASEDIR="$PWD" usr/bin/connectd_installer_deprecated
sed -i '/^BASEDIR=/c\BASEDIR="$PWD" usr/bin/connectd_register_deprecated
sed -i '/^BASEDIR=/c\BASEDIR="$PWD" etc/init.d/connectd
sed -i '/^BASEDIR=/c\BASEDIR="$PWD" etc/init.d/connectd_schannel
