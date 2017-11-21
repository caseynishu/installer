NOTE: connectd_1.3-08 is currently in EVALUATION phase. We expect there to be minor issues running it on various platforms.  We will change this announcement when it is released.

To install remot3.it connectd services to your Debian system:
1) Copy the appropriate deb file to your system.
2) Run "sudo dpkg -i <debfilename>"
3) Now run "sudo connectd_installer" to install services interactively.
4) Edit and run /usr/bin/connectd for a table-based installation suitable for mass production.
=============================================================
The connectd_1.3-08 folder contains the source files for the Debian package creation process.

lintpkg.sh is a script you can run on your Debian/Ubuntu system to build, run Lintian, and move the resulting deb to the /var/www folder on your development system.  The assumption is that you have a web server running locally so that you can switch to your target system and easily retrieve the deb file using wget.

sgwi.sh is handy during development when repeatedly editing the weavedinstaller.sh since it deletes the backup file and runs as su, so you don't have to change permissions on the file itself (which messes things up during package creation).

sgwd.sh is handy during development when repeatedly editing the Debian package control files and maintainer scripts since it deletes the backup file and runs as su, so you don't have to change permissions on the files themselves.
