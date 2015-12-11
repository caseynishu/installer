The file weaved_artik.tar will let you add Weaved remote connection services to your ARTIK 5 or 10 board running Fedora Linux.

Download and install Weaved to your ARTIK with these commands:

cd ~

wget https://github.com/weaved/installer/raw/master/Samsung%20Artik/weaved_artik.tar

tar xvf weaved_artik.tar

cd weaved_software

./weavedinstaller

=============================================================
Then, whenever you wish to add or remove a Weaved service, run:

weavedconfigure

=============================================================
To uninstall Weaved from your Artik:

run weavedconfigure and remove all installed Weaved services.  Then,

cd ~/weaved_software

./weaveduninstall

cd ..

/bin/rm -r weaved_software

=============================================================

