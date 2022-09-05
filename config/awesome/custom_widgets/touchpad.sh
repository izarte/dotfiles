#!/usr/bin/env bash

declare -i ID
ID=$(xinput --list | grep -i TouchPad | cut -d '=' -f 2 | cut -f 1)
declare -i STATE
STATE=$( xinput --list-props $ID | grep Enabled | cut -f 3 )

if [ $STATE -eq 1 ]
then
    xinput disable $ID
    echo "Touchpad disabled."
#    xsetroot -name "Touchpad disabled!"
else
    xinput enable $ID
    echo "Touchpad enabled."
#    xsetroot -name "Touchpad enabled!"
fi
