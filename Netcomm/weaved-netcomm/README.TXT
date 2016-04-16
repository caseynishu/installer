Netcomm simple installer package for Weaved remot3-it Target Device
--------------------------------------------------------------------
This installer places all files in the proper directories
for an unconfigured Netcomm device.  If this installer is run on a configured system
Weaved remot3-it must be disabled/shutdown before running (see upgrade
switch).


Installs Weaved remot3-it on a Netcomm router/gateway.

type:

./install 

from this directory (/root/weaved-netcomm) to install.


Copies weavedConnectd.arm-gnueabi-shared to /usr/bin/weavedconnectd

Copies task_notify.sh to /usr/bin/task_notify.sh

Copies schannel.arm-gnuabi to /usr/bin/schannel

Copies weavedregister_net to /usr/bin/weavedregister_net

Copies weavedsimplelib /usr/bin/weavedsimplelib

Create the directory /etc/weaved

Creates the directory /etc/weaved/pfiles

Creates the directory /etc/weaved/available

Creates the directory /etc/weaved/active

Coplies the schanne.conf to /etc/weaved

Copies enablement files to /etc/weaved/pfiles

Copies startup scripts to /etc/init.d

Symlinks the startup scripts to /etc/init.d/rc3.d/S700*  so they will start at boot

At this point the modem should be in a state to ship to a customer with weaved remot3-it support.


-----------------------------------------------------

To register a modem on the Weaved service, the weavedregister_net script can be called.

The weavedregister_net script takes up to 3 parameters in the following format:

weavedregister_net [weaved username] [weaved_authhash] [weaved_password]

If a weaved password is being used then the weaved_authash must be set to 0

Example:

weavedregister_net user1 0 user1password

If one or more of these fields are not set it will try to use interactive mode.

Once called and the username and password are correct, this script will register
the bulk managment, SSH and WEB remote function for the device on the Weaved remot3-it service to 
the account specified.

The naming will be based on the devices IMEI from the RDB value wwan.0.imei



















