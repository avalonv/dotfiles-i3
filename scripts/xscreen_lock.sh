#!/usr/bin/env bash

battery='BAT1'

if ! pgrep 'xscreensaver -no-splash'; then
    xscreensaver -no-splash &
    sleep 2
fi

if [[ $(cat /sys/class/power_supply/$battery/status) = 'Discharging' ]]; then
    xscreensaver-command -lock
    sleep 5
    sudo zzz
else
    xscreensaver-command -lock
fi


exit $?
