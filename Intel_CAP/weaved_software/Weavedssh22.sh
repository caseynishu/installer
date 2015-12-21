#!/bin/bash

#  launchweaved.sh
#  
#
#  Weaved, Inc. Copyright 2014. All rights reserved.
#

VERSION="v1.01"
AUTHOR="Mike Young"
MODIFIED="December 18, 2015"
WEAVED_PORT=Weavedssh22
DAEMON=weavedConnectd.linux
WEAVED_DIR=/etc/weaved/services
BIN_DIR=/usr/bin
PID_DIR=/var/run
BIN_PATH=$BIN_DIR/$DAEMON
PIDPATH=$PID_DIR/$WEAVED_PORT.pid
LOG_FILE=/dev/null
LOG_DIR=/var/log


checkPID()
{
	if [ -f $PIDPATH ]; then
		runningPID="$(cat $PIDPATH)"
	fi
}

isRunning()
{
	isRunning="$(ps ax | grep weaved | grep $WEAVED_PORT | grep -v grep | wc -l)"
}

stopWeaved()
{
	isRunning
	checkPID
	if [ $isRunning != 0 ]; then
		echo "Stopping $WEAVED_PORT..."
		sudo kill $runningPID 2> /dev/null
		sudo rm $PIDPATH 2> /dev/null
	else
		echo "$WEAVED_PORT is not currently active. Nothing to stop."
	fi
}

startWeaved()
{
	isRunning
	if [ $isRunning = 0 ]; then
		echo "Starting $WEAVED_PORT..."
		sudo $BIN_DIR/$DAEMON -f $WEAVED_DIR/$WEAVED_PORT.conf -d $PID_DIR/$WEAVED_PORT.pid > $LOG_DIR/$WEAVED_PORT.log
		tail $LOG_DIR/$WEAVED_PORT.log
	else
		echo "$WEAVED_PORT is already started"
	fi
}

restartWeaved()
{
	stopWeaved
	sleep 2
	startWeaved
}

##### Version #####
displayVersion()
{
    printf "Version: %s \n" "$VERSION"
    # check for sudo user at this point
    if [[ $EUID -ne 0 ]]; then
        echo "Running $WEAVED_PORT.sh requires root access." 1>&2
        echo "Please run sudo $WEAVED_PORT.sh." 1>&2
	exit 1
    fi
}
##### End Version #####

displayVersion

if [ -z $1 ]; then
	echo "You need one of the following arguments: start|stop|restart"
	exit
elif [ "$(echo "$1" | tr '[A-Z]' '[a-z]' | tr -d ' ')" = "stop" ]; then 
	stopWeaved
elif [ "$(echo "$1" | tr '[A-Z]' '[a-z]' | tr -d ' ')" = "start" ]; then
	startWeaved
elif [ "$(echo "$1" | tr '[A-Z]' '[a-z]' | tr -d ' ')" = "restart" ]; then
	restartWeaved
else
	echo "This option is not supported"
fi

