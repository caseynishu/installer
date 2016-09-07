#!/bin/bash

#  launchweaved.sh
#  
#
#  Weaved, Inc. Copyright 2016. All rights reserved.
#

VERSION="v1.4"
AUTHOR="Gary Worsham"
MODIFIED="April 4, 2016"
WEAVED_PORT=
DAEMON=weavedconnectd.i686
WEAVED_DIR=/etc/weaved/services
BIN_DIR=/usr/bin
PID_DIR=/var/run
BIN_PATH=$BIN_DIR/$DAEMON
PIDPATH=$PID_DIR/$WEAVED_PORT.pid
LOG_FILE=/dev/null
LOG_DIR=/var/log

##### Version #####
displayVersion()
{
    printf "Weaved daemon start/stop script Version: %s \n" "$VERSION"
    # check for root user at this point
    if [[ $EUID -ne 0 ]]; then
        echo "Running $WEAVED_PORT.sh requires root access." 1>&2
        echo "Please run sudo $WEAVED_PORT.sh" 1>&2
	exit 1
    fi
}
##### End Version #####


isRunningCmd()
{
	if [ -f $PIDPATH ]; then
		runningPID="$(cat $PIDPATH)"
	fi
	# see if there is ANY matching line with weaved and $WEAVED_PORT.conf
	# isRunning will be 0 if NOTHING matches
	isRunningLine="$(ps ax | grep weaved | grep -w "$WEAVED_PORT.conf" | grep -v grep)"
	isRunningps=$(echo -n $isRunningLine | wc -w)
	ps ax | grep weaved | grep -w "$WEAVED_PORT.conf" | grep -v grep > /tmp/weavedps.txt
	#-------------	
	# this next part is to ensure, when Weaved services are installed on
	# a VM and containers within that VM, that we can correctly identify 
	# the PID corresponding the the service running on the VM. This is the
	# one which has a matching PID in /var/run/$WEAVED_PORT.pid
	#-------------	
	isRunning=0
	while read p; do
  	    psPID=$(echo $p | awk '{ print $1 }')
	    if [[ "$psPID" == "$runningPID" && "$isRunningps" != "0" ]]; then
#		echo "Matching PID! $psPID"
		isRunning=1
		return
	    fi
	done < /tmp/weavedps.txt
}

stopWeaved()
{
	isRunningCmd
	if [[ $isRunning != 0 && $psPID == $runningPID ]]; then
		echo "Stopping $WEAVED_PORT..."
		kill $runningPID 2> /dev/null
		rm $PIDPATH 2> /dev/null
	else
		echo "$WEAVED_PORT is not currently active. Nothing to stop."
	fi
}

startWeaved()
{
	isRunningCmd
	if [ $isRunning == 0 ]; then
		echo "Starting $WEAVED_PORT..."
		$BIN_DIR/$DAEMON -f $WEAVED_DIR/$WEAVED_PORT.conf -d $PID_DIR/$WEAVED_PORT.pid > $LOG_DIR/$WEAVED_PORT.log
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

