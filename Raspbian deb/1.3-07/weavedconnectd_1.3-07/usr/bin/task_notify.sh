#!/bin/bash
#
# Copyright (C) 2016 remot3.it
#
# This is a notification plugin for for bulk managment.  
#
# The calling formats are as follows:
#
# task_notify.sh [cmd] [taskid] [api] [status]
#
# task_notify.sh 0 [taskid] [api] [status]
#       returns 200 OK for   
#
# task_notify.sh 1
#       returns 200 OK for 
#
# Usage:  task_notify.sh <cmd> <taskid> <api> <status>
# 
# task_notify.sh [0/1/2/3] <$taskid> <api> <$status>
#
# set -x

#### Settings #####
VERSION=0.6
MODIFIED="October 26, 2016"
#
# Log to system log if set to 1
LOGGING=1
VERBOSE=0
#
#
apiMethod="https://"
#apiServerCall="${apiMethod}${apiServer}${apiVersion}"

# Config curl path
CURL="curl"

#Default values
TMP="/tmp"
# Don't veryify SSL (-k) Silent (-s)
CURL_OPS=" -s"
DEBUG=1
#SRC=$1
#DST=$2
OUTPUT="$TMP/weaved_task_notify"

#
# Build API URLS GET API's                                                                                                          
API_TASK_UPDATE="/bulk/job/task/update/"    
API_TASK_DONE="/bulk/job/task/done/"
API_TASK_FAILED="/bulk/job/task/failed/"
API_DEVICE_STATUS="/bulk/service/status/"
API_DEVICE_STATUS_A="/bulk/service/status/a/"
API_DEVICE_STATUS_B="/bulk/service/status/b/"

#
# Helper Functions
#
#produces a unix timestamp to the output
utime()
{ 
    echo $(date +%s)
}

# produces a random number ($1 digits) to the output (supports upto 50 digits for now)
dev_random()
{
    local count=$1
    
    #default is 10 digits if none specified
    count=${1:-10};

    #1 to 50 digits supported    
    if [ "$count" -lt 1 ] || [ "$count" -ge 50 ]; then
        count=10;
    fi

    # uses /dev/urandom
    ret=$(cat /dev/urandom | tr -cd '0-9' | dd bs=1 count=$count 2>/dev/null)
    echo $ret
}

#
# JSON parse (very simplistic):  get value frome key $2 in buffer $1,  values or keys must not have the characters {}", and the key must not have : in them
#
jsonval()
{
    temp=`echo $1 | sed -e 's/[{}"]//g' -e 's/,/\n/g' | grep -w $2 | cut -d":" -f2-`
    echo ${temp##*|}
}


#
# urlencode $1
#
urlencode()
{
STR=$1
[ "${STR}x" == "x" ] && { STR="$(cat -)"; }

echo ${STR} | sed -e 's| |%20|g' \
-e 's|!|%21|g' \
-e 's|#|%23|g' \
-e 's|\$|%24|g' \
-e 's|%|%25|g' \
-e 's|&|%26|g' \
-e "s|'|%27|g" \
-e 's|(|%28|g' \
-e 's|)|%29|g' \
-e 's|*|%2A|g' \
-e 's|+|%2B|g' \
-e 's|,|%2C|g' \
-e 's|/|%2F|g' \
-e 's|:|%3A|g' \
-e 's|;|%3B|g' \
-e 's|=|%3D|g' \
-e 's|?|%3F|g' \
-e 's|@|%40|g' \
-e 's|\[|%5B|g' \
-e 's|]|%5D|g'
}

#
#
#
return_code()
{
    case $resp in
        "200")
            #Good Reponse
            echo "$resp OK"
            ;;
        "404")
            #Good Reponse
            echo "$resp Not found!"
            ;;
        "429")
            #Good Reponse
            echo "$resp API server busy!"
            ;;
        "500")
            ret=$(jsonval "$(cat $OUTPUT)" "error") 
            echo "$resp $ret"
            ;;
        *)
            echo "$resp FAIL"
            ;;
    esac
}


#
# Print Usage
#
usage()
{
        if [ $LOGGING -gt 0 ]; then 
            logger "[task_notify.sh Called with bad format or -h]" 
        fi

        echo "Usage: $0 [-v (verbose)] [-v (maximum verbosity)] [-h (this message)] <CMD> <TASKID> <API> <STATUS>" >&2
        echo "     [optional] Must specify <CMD> <TASKID> <API> and <STATUS>" >&2
        echo "     CMD=0   --> update status " >&2
        echo "     CMD=1   --> completed status " >&2
        echo "     CMD=2   --> failed status " >&2
        echo "     CMD=3   --> status A " >&2
        echo "     CMD=4   --> status B " >&2
        echo "Version $VERSION Build $MODIFIED" >&2
        exit 1
}

###############################
# Beginning of backoff/retry wrapper function
###############################
# Retries a command a configurable number of times with backoff timeout.
#
# The maximum retry count is given by MAX_ATTEMPTS
# The initial backoff timeout is TIMEOUT_INITIAL
# The minimum timeout to be used is TIMEOUT_MIN
# The cap on the timeout to be used is TIMEOUT_CAP
# The base or multiplier to be used in calculating successive timeouts is TIMEOUT_BASE
#
# Successive backoffs increase the timeout.
# See https://www.awsarchitectureblog.com/2015/03/backoff.html
# See also http://stackoverflow.com/questions/8350942/how-to-re-run-the-curl-command-automatically-when-the-error-occurs (edited)
#

random_between() {
 local range_min=$1;
 local range_max=$2;
 echo $(( RANDOM % (range_max - range_min + 1 ) + range_min ));
}

min() {
 echo $([ $1 -le $2 ] && echo "$1" || echo "$2")
}

with_backoff () {

 local max_attempts=${MAX_ATTEMPTS-10} # default = 10 attempts
 local timeout_initial=${TIMEOUT_INITIAL-1} # default = 1 second
 local timeout_min=${TIMEOUT_MIN-1} # default = 1 second
 local timeout_cap=${TIMEOUT_CAP-600} # default = 600 seconds
 local timeout_base=${TIMEOUT_BASE-1} # default = 1
 local timeout=${timeout_initial}
 local attempt=0
 
 local exitCode=0

# echo "attempt = $attempt max_attempts = $max_attempts"

while (( $attempt < $max_attempts ))
 do
   set +e
   "$@"
   exitCode=$?
   set -e

   if [[ $exitCode == 0 ]]
   then
     break
   fi

   echo "Failure $exitcode! Retrying in $timeout..." 1>&2
   
#debug and test
#test1=$( min 1 2 )
#test2=$( random_between 1 10 )
#test3=$( min 600 1 )
#test4=$( min $timeout_cap 1 )

# The intermediate variables in the code below have been constructed so that changing
# the formula for backoff timeout should be straightforward.
#
# The code below implements "full jitter":
# sleep = random_between(0, min(cap, base * 2 ** attempt))
#
# You can also use "decorrelated jitter":
# sleep = min(cap, random_between(base, sleep * 3))
#
# An alternative "equal Jitter" is not recommended:
# temp = min(cap, base * 2 ** attempt)
# sleep = temp / 2 + random_between(0, temp / 2)
#
# The simple "exponential" is also not recommended:
# sleep = min(cap, base * 2 ** attempt)

   sleep $timeout
   attempt=$(( $attempt + 1 ))
   temp1=$(( 2** $attempt ))
   temp2=$(( $timeout_base * $temp1 ))
   temp3=$( min $timeout_cap $temp2 )
   timeout=$( random_between $timeout_min $temp3 )

#debug and test
#echo "attempt = $attempt temp1 = $temp1 temp2 = $temp2 temp3 = $temp3 timeout = $timeout"


 done

 if [[ $exitCode != 0 ]]
 then
   echo "You've failed me for the last time! ($@)" 1>&2
echo
echo "with_backoff exitcode = $exitcode"
echo
 fi

 return $exitCode
}

# example: with_backoff curl 'https://google.com/'
###############################
# end of backoff/retry wrapper function
###############################

# sendAPIresponse sends the proper command to the given URL
# 
sendAPIresponse() {
        data="{\"taskid\":\"${task_id}\",\"description\":\"${status}\"}"

        resp=$(with_backoff $CURL $CURL_OPS -w "%{http_code}\\n" -X POST -o "$OUTPUT" "$1" -d "$data")
echo "sendAPIresponse curl resp = $resp"
	if [ "$resp" -eq 200 ]; then
           # echo URL "return USERID"
           ret=$(jsonval "$(cat $OUTPUT)" "status")
           echo "$resp $ret"
       else
           ret=$(jsonval "$(cat $OUTPUT)" "reason")
           echo "[task_notify.sh failed with $resp, $ret]"
           echo $(return_code $resp)
       fi

}
###############################
# Main program starts here    #
###############################
#

################################################
# parse the flag options (and their arguments) #
################################################
while getopts vh OPT; do
    case "$OPT" in
      v)
        VERBOSE=$((VERBOSE+1)) ;;
      h | [?])
        # got invalid option
        usage
        ;;
    esac
done

# get rid of the just-finished flag arguments
shift $(($OPTIND-1))

# make sure we have at least 4 cmd, taskid , api and status
if [ $# -lt 4 ]; then
    usage
fi

# Parse off command
cmd=$1
shift

#Parse off taskid
task_id=$1
shift

#Parse off api
api_base=$1
shift

status="$@"

if [ $LOGGING -gt 0 ]; then 
    logger "[task_notify.sh Called with cmd $cmd taskid $task_id value $status]" 
fi
if [ $VERBOSE -gt 0 ]; then
    echo "[task_notify.sh Called with cmd $cmd taskid $task_id value $status]"
fi

#
case $cmd in
    "0")
        #
        # Send Update 
        #
        URL="$apiMethod$api_base$API_TASK_UPDATE"
	    sendAPIresponse $URL
    ;;

    "1")
        #
        # Task Done 
        #
        URL="$apiMethod$api_base$API_TASK_DONE"
	    sendAPIresponse $URL
    ;;
    "2")
        #
        # Task Failed 
        #
        URL="$apiMethod$api_base$API_TASK_FAILED"
	    sendAPIresponse $URL
    ;;
    "3" | "A" | "a")
        # device status A
        URL="$apiMethod$api_base$API_DEVICE_STATUS_A"
	    sendAPIresponse $URL
    ;;
    "4" | "B" | "b")
        # device status 2
        URL="$apiMethod$api_base$API_DEVICE_STATUS_B"
	    sendAPIresponse $URL
    ;;
    '5' | 'C' | 'c')
        generic='c'
    ;;
    '6' | 'D' | 'd')
        generic='d'
    ;;
    '7' | 'E' | 'e')
        generic='e'
    ;;
    '8' | 'F' | 'f')
        generic='f'
    ;;
    '9' | 'G' | 'g')
        generic='g'
    ;;
    '10' | 'H' | 'h')
        generic='h'
    ;;
    '11' | 'I' | 'i')
        generic='i'
    ;;
    '12' | 'J' | 'j')
        generic='j'
    ;;
esac

# Do Generic Call
if [ -n "$generic" ]; then

    # device status Generic
    URL="$apiMethod$api_base$API_DEVICE_STATUS$generic/"
    data="{\"taskid\":\"${task_id}\",\"description\":\"${status}\"}"

    resp=$(with_backoff $CURL $CURL_OPS -w "%{http_code}\\n" -X POST -o "$OUTPUT" $URL -d "$data")

    if [ "$resp" -eq 200 ]; then
        # echo URL "return USERID"
        ret=$(jsonval "$(cat $OUTPUT)" "status")
        echo "$resp $ret"
    else
        return_code $resp
    fi
fi


# flush multiple returns
echo


