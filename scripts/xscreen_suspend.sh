#!/usr/bin/env bash

timefile=$(mktemp --suffix xscreensaver)
timeout=360 # 6 minutes
battery='BAT1'

function update_date
{
    date '+%s' > $timefile
}

function time_passed
{
    last=$(cat $timefile)
    curr=$(date '+%s')
    echo $(( $curr - $last ))
}

function battery_discharging
{
    if [[ $(cat /sys/class/power_supply/$battery/status) = 'Discharging' ]]; then
        return 0
    else
        return 1
    fi
}

update_date

while true; do
    battery_discharging
    if [[ $? = '0' ]] && xscreensaver-command -time 2>&1| egrep -q "locked|\sblanked"; then
        x=$(time_passed)
        if (( $x > $timeout )); then
            sudo zzz
            sleep 5
            update_date
        fi
    fi

    if xscreensaver-command -time 2>&1 | egrep -q 'non-blanked|no screensaver'; then
        update_date
        sleep 30
    fi
    sleep 10
done
