=============================================================
To install Weaved to your ARM Debian system:
1) Copy the deb file to your system.  You can download it directly using:
   wget https://github.com/weaved/installer/raw/master/Raspbian%20deb/1.3-03/weavedconnectd-1.3-03.deb
2) Run "sudo dpkg -i weavedconnectd-1.3-03.deb"
3) Now run "sudo weavedinstaller"
4) Follow the on screen menus to add or remove Weaved services.
=============================================================
The weavedconnectd-1.3-03 folder contains the source files for the Debian package creation process.

lintpkg.sh is a script you can run on your Debian/Ubuntu system to build, run Lintian, and move the resulting deb to the /var/www folder on your development system.  The assumption is that you have a web server running locally so that you can switch to your target system and easily retrieve the deb file using wget.

sgwi.sh is handy during development when repeatedly editing the weavedinstaller.sh since it deletes the backup file and runs as su, so you don't have to change permissions on the file itself (which messes things up during package creation).
