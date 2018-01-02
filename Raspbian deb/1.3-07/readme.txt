To install Weaved to your ARM Debian system:
1) Choose the latest deb file for your platform.  We now have both armhf (which should be used for Raspberry Pi, BeagleBone Black, and WandBoard) and armel versions.

2) Click on the link and then the "Download" button to download the file.  Right-click on the "Download" button to copy the link to use with wget on the command line, e.g.

pi@raspberrypi:~ $ wget https://github.com/weaved/installer/raw/master/Raspbian%20deb/1.3-07/weavedconnectd_1.3-07z_armhf.deb
--2017-11-17 09:01:24--  https://github.com/weaved/installer/raw/master/Raspbian%20deb/1.3-07/weavedconnectd_1.3-07z_armhf.deb
Resolving github.com (github.com)... 192.30.253.112, 192.30.253.113
Connecting to github.com (github.com)|192.30.253.112|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://raw.githubusercontent.com/weaved/installer/master/Raspbian%20deb/1.3-07/weavedconnectd_1.3-07z_armhf.deb [following]
--2017-11-17 09:01:25--  https://raw.githubusercontent.com/weaved/installer/master/Raspbian%20deb/1.3-07/weavedconnectd_1.3-07z_armhf.deb
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.40.133
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.40.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 110112 (108K) [application/octet-stream]
Saving to: ‘weavedconnectd_1.3-07z_armhf.deb’

weavedconnectd_1.3-07z_armhf 100%[============================================>] 107.65K  51.7KB/s   in 2.1s   

2017-11-17 09:01:28 (51.7 KB/s) - ‘weavedconnectd_1.3-07z_armhf.deb’ saved [110378/110378]

MD5 checksums:
a1f1e86c569fe34bfabe6aed195a829e  weavedconnectd_1.3-07z_armel.deb
d18d92800a921b1e4642dd8ebaeb9072  weavedconnectd_1.3-07z_armhf.deb

3) Run "sudo dpkg -i <deb file name>"
4) Now run "sudo weavedinstaller" to install remot3.it services individually from the on-screen menus.
5) Or alternatively, you may edit and run /usr/bin/remot3_register for a table-based installation script suitable for mass production.
=============================================================
The weavedconnectd_1.3-07 folder contains the source files for the Debian package creation process.

lintpkg.sh is a script you can run on your Debian/Ubuntu system to build the deb package, run Lintian, and present an error/warning summary.  You need to choose between armel and armhf architecture.

sgwi.sh is handy during development when repeatedly editing the weavedinstaller.sh since it deletes the backup file and runs as su, so you don't have to change permissions on the file itself (which messes things up during package creation).

sgwd.sh is handy during development when repeatedly editing the Debian package control files and maintainer scripts since it deletes the backup file and runs as su, so you don't have to change permissions on the files themselves.
