#!/bin/bash
FOLDERNAME=$(pwd | awk -F "/" '{ print $5 }')
BINDIR=$FOLDERNAME/usr/bin
MANDIR=$FOLDERNAME/usr/share/man/$FOLDERNAME
echo $BINDIR
echo $MANDIR
# set -x

if [ ! -d $MANDIR ]; then
    mkdir $MANDIR
fi
for f in weavedconnectd.i686 weavedconnectd.linux; do
    echo
    help2man -h="-h" $BINDIR/$f > $MANDIR/$f.1
    gzip -9 $MANDIR/$f.1
done
