To install Weaved to your x86 64-bit Debian system:
1) Copy the deb file to your system.  We now have both armhf and armel versions.
2) Run "sudo dpkg -i <deb file name>"
3) Now run "sudo weavedinstaller" to install remot3.it services individually from the on-screen menus.
4) Or alternatively, you may edit and run /usr/bin/remot3_register for a table-based installation script suitable for mass production.
=============================================================
The weavedconnectd_1.3-07 folder contains the source files for the Debian package creation process.

lintpkg.sh is a script you can run on your Debian/Ubuntu system to build the deb package, run Lintian, and present an error/warning summary.  You need to choose between armel and armhf architecture.

sgwi.sh is handy during development when repeatedly editing the weavedinstaller.sh since it deletes the backup file and runs as su, so you don't have to change permissions on the file itself (which messes things up during package creation).

sgwd.sh is handy during development when repeatedly editing the Debian package control files and maintainer scripts since it deletes the backup file and runs as su, so you don't have to change permissions on the files themselves.
