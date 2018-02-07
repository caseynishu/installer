To install Weaved to your x86 64-bit Debian system:
1) Download the deb file to your system. 

$ wget https://github.com/weaved/installer/raw/master/Ubuntu_deb/weavedconnectd_1.3-07_x86/weavedconnectd_1.3-07k_x86.deb
--2018-02-05 12:48:41--  https://github.com/weaved/installer/raw/master/Ubuntu_deb/weavedconnectd_1.3-07_x86/weavedconnectd_1.3-07k_x86.deb
Resolving github.com (github.com)... 192.30.255.112, 192.30.255.113
Connecting to github.com (github.com)|192.30.255.112|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://raw.githubusercontent.com/weaved/installer/master/Ubuntu_deb/weavedconnectd_1.3-07_x86/weavedconnectd_1.3-07k_x86.deb [following]
--2018-02-05 12:48:41--  https://raw.githubusercontent.com/weaved/installer/master/Ubuntu_deb/weavedconnectd_1.3-07_x86/weavedconnectd_1.3-07k_x86.deb
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 151.101.40.133
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|151.101.40.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 108840 (106K) [application/octet-stream]
Saving to: ‘weavedconnectd_1.3-07k_x86.deb’

weavedconnectd_1.3-07k_x86.deb        100%[======================================================================>] 106.29K  --.-KB/s    in 0.02s   

2018-02-05 12:48:42 (5.92 MB/s) - ‘weavedconnectd_1.3-07k_x86.deb’ saved [108840/108840]

2) Confirm the MD5 checksum:

$ md5sum weavedconnectd_1.3-07k_x86.deb 
dabdac3a8f36db78afc9fbbdc5dbdfbd  weavedconnectd_1.3-07k_x86.deb
-------------------------------------------------------------------------------------------------------------------
3) Run "sudo dpkg -i <deb file name>"
4) Now run "sudo weavedinstaller" to install remot3.it services individually from on-screen menus.
5) Or alternatively, you may edit and run /usr/bin/remot3_register for a table-based installation script suitable for mass production.
=============================================================
The weavedconnectd_1.3-07 folder contains the source files for the Debian package creation process.

lintpkg.sh is a script you can run on your Debian/Ubuntu system to build the deb package, run Lintian, and present an error/warning summary.  You need to choose between armel and armhf architecture.

sgwi.sh is handy during development when repeatedly editing the weavedinstaller.sh since it deletes the backup file and runs as su, so you don't have to change permissions on the file itself (which messes things up during package creation).

sgwd.sh is handy during development when repeatedly editing the Debian package control files and maintainer scripts since it deletes the backup file and runs as su, so you don't have to change permissions on the files themselves.
