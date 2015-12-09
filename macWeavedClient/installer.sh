#!/bin/bash
#
#  Installer for Weaved Launcher for MAC-OSX
#

create_dir()
{
    # create /usr/local directory if it does not exist (apple screwed up on some OSX versions)
    if [ ! -d "/usr/local" ]; then
        mkdir "/usr/local"
        chmod 755 "/usr/local"
    fi
    # create /usr/local/bin directory if it does not exist (apple screwed up on some OSX versions)
    if [ ! -d "/usr/local/bin" ] ; then
       mkdir "/usr/local/bin" 
       chmod 755 "/usr/local/bin"
    fi
}

must_be_sudo()
{
    echo " "
    echo "Error: Your need elevated permissions to install.  Rerun this script as sudo ./installer.sh"
    echo " "
    exit 1    
}

check_dir()
{
    if [ ! -d "/usr/local/bin" ] ; then
        must_be_sudo
    fi
}



printf "\nWeaved Client Installer for MACOSX\n\n"

create_dir
check_dir

read -p "Press [Enter] to Install Weaved Clients to MACOSX - ctrl-c to Abort"

printf "\n.\n"
printf "\nCopying files to /usr/local/bin \n"

if [ -d "/usr/local/bin/wlib.sh" ] ; then
    rm "/usr/local/bin/wlib.sh"
    if [ -d "/usr/local/bin/wlib.sh" ] ; then
        must_be_sudo
    fi
fi
cp wlib.sh /usr/local/bin
chmod 755 /usr/local/bin/wlib.sh

if [ ! -f "/usr/local/bin/wlib.sh" ] ; then
   must_be_sudo 
fi

printf "."
cp sshw.sh /usr/local/bin
chmod 755 /usr/local/bin/sshw.sh
ln -s /usr/local/bin/sshw.sh /usr/local/bin/sshw
printf "."
cp sftpw.sh /usr/local/bin
chmod 755 /usr/local/bin/sftpw.sh
ln -s /usr/local/bin/sftpw.sh /usr/local/bin/sftpw
printf "."
cp wweb.sh /usr/local/bin
chmod 755 /usr/local/bin/wweb.sh
ln -s /usr/local/bin/wweb.sh /usr/local/bin/wweb
printf "."

cp smbw.sh /usr/local/bin
chmod 755 /usr/local/bin/smbw.sh
ln -s /usr/local/bin/smbw.sh /usr/local/bin/smbw
printf "."

cp weavedConnectd.macosx /usr/local/bin/weavedConectd
chmod 755 /usr/local/bin/weavedConectd
echo " "
echo " "
echo "sshw sftpw wweb and smbw are now installed"
echo " "



