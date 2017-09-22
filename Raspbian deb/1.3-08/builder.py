# builder.py - to build versions of connectd  for different architectures
import os
import fnmatch
import string

DAEMON_DIR="./daemons"
TMP_FILE="/tmp/.builderfiles"

#rm "$TMP_FILE"
try:
    os.remove(TMP_FILE)
except OSError:
    pass

i=0
list = []

for file in os.listdir(DAEMON_DIR):
    if fnmatch.fnmatch(file, 'weavedConnectd.*'):
        # print file
        architecture = string.split(file,'.', 1)
        list.append(architecture[1])
        print i+1, ") ", list[i]
        i = i + 1

