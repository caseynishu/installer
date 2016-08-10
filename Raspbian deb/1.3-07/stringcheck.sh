#!/bin/bash
while [ 1 ]; do
echo "enter string to check"
read string

if ! [[ "$string" =~ [^-a-zA-Z0-9\ \_] ]]; then
    echo "$string is valid"
else
    echo "$string is invalid"
fi

done
