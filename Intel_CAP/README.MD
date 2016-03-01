These instructions show you how to install Weaved services (daemons) on the Intel CAP device for:

* ssh on port 22
* http on port 80 (lesson update portal)
* http on port 8080 (admin portal)

Copy the weaved_IntelCAP.tar to the /root folder of the CAP.

* cd /root
* wget https://github.com/weaved/installer/raw/master/Intel_CAP/weaved_IntelCAP.tar

Run the following command:

* tar xvf weaved_IntelCAP.tar

This creates a folder weaved_software with all of the files needed for installation.

To install the 3 services,

* cd /root/weaved_software
* sudo ./install.sh

To register the services to a Weaved account, first create your account at developer.weaved.com, then click on the Services 
List link at the top of the page.

You will see 3 green boxes showing the Services which have been detected.
Click on the words "Register Now" for each device, after which you will be asked to give that service a name.
After giving each device a name, it may take up to 5 minutes for each Service to show as an active link.

To access a web service, just click on the link.

For the SSH connection, see https://www.weaved.com/using-weaved-with-ssh-scp-sftp/ for a variety of ways to access a remote 
console or perform file transfers.

To uninstall the 3 services,

* cd /root/weaved_software
* sudo ./uninstall.sh

To reset the services so that they are no longer registered to a user account (i.e. factory reset), run:

* cd /root/weaved_software
* sudo ./unregister.sh

See additional information in the readme.txt in /root/weaved_software.
