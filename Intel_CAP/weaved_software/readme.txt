Weaved Installer for Intel CAP

Run sudo ./install.sh
1) Copies Weaved daemon weavedConnectd.linux to /usr/bin
2) Copies service start/stop scripts Weavedssh22.sh, Weavedhttp80.sh, and Weavedhttp8080.sh to /usr/bin
3) Copies provisioning files Weavedssh22.conf, Weaveddhttp80.conf, and Weavedhttp8080.conf to /etc/weaved/services
4) Copies weavedStart.sh and weavedStop.sh to /usr/bin.  These scripts start or stop all installed Weaved services, respectively.
5) Adds entry to root crontab to run /usr/bin/weavedStart.sh at reboot

Run sudo ./uninstall.sh
1) Deletes all binaries and scripts from /usr/bina
2) Removes folder /etc/weaved and all contents (provisioning files)
3) Removes weavedStart.sh line from root crontab

Run sudo ./unregister.sh
1) Stops all running Weaved daemons
2) Clears all provisioning files in /etc/weaved/services to initial condition
3) After reboot, device will be in "factory reset" mode - daemons running but not registered to any account.
