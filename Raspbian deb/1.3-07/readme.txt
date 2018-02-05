To install Weaved to your ARM Debian system:
1) Choose the latest deb file for your platform.  We now have both armhf (which should be used for Raspberry Pi, BeagleBone Black, and WandBoard) and armel versions.

2) Click on the link and then the "Download" button to download the file.  Right-click on the "Download" button to copy the link to use with wget on the command line, e.g.

pi@raspberrypi-90:~ $ wget https://github.com/weaved/installer/raw/master/Raspbian%20deb/1.3-07/weavedconnectd_1.3-07z1_armhf.deb
--2018-02-05 12:32:58--  https://github.com/weaved/installer/raw/master/Raspbian%20deb/1.3-07/weavedconnectd_1.3-07z1_armhf.deb
Resolving github.com (github.com)... 192.30.255.112, 192.30.255.113
Connecting to github.com (github.com)|192.30.255.112|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://raw.githubusercontent.com/weaved/installer/master/Raspbian%20deb/1.3-07/weavedconnectd_1.3-07z1_armhf.deb [following]
--2018-02-05 12:32:59--  https://raw.githubusercontent.com/weaved/installer/master/Raspbian%20deb/1.3-07/weavedconnectd_1.3-07z1_armhf.deb
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.40.133
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.40.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 110474 (108K) [application/octet-stream]
Saving to: ‘weavedconnectd_1.3-07z1_armhf.deb’

weavedconnectd_1.3-07z1_armhf.deb     100%[======================================================================>] 107.88K  --.-KB/s    in 0.06s   

2018-02-05 12:32:59 (1.76 MB/s) - ‘weavedconnectd_1.3-07z1_armhf.deb’ saved [110474/110474]

MD5 checksums:
bfb7180b6b0d6060035e3bb35d90ccff  weavedconnectd_1.3-07z1_armel.deb
f5085b84740f992f00e2c5b791b75d27  weavedconnectd_1.3-07z1_armhf.deb

3) Run "sudo dpkg -i <deb file name>"
4) Next, run "sudo weavedinstaller" to install remot3.it services individually from the on-screen menus.
5) Or alternatively, you may edit and run /usr/bin/remot3_register for a table-based installation script suitable for mass production.
=============================================================
The weavedconnectd_1.3-07 folder contains the source files for the Debian package creation process.

lintpkg.sh is a script you can run on your Debian/Ubuntu system to build the deb package, run Lintian, and present an error/warning summary.  You need to choose between armel and armhf architecture.

sgwi.sh is handy during development when repeatedly editing the weavedinstaller.sh since it deletes the backup file and runs as su, so you don't have to change permissions on the file itself (which messes things up during package creation).

sgwd.sh is handy during development when repeatedly editing the Debian package control files and maintainer scripts since it deletes the backup file and runs as su, so you don't have to change permissions on the files themselves.
