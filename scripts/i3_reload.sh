#!/usr/bin/env bash

echo "=========RELOADING I3========="
xrdb ~/.Xresources

# when starting i3 for the first time
if [[ $1 == 'start' ]]; then
    startall='true'
    shift
fi

#urxvt_color="-bg '#040008'"
echo 'Launching scratchpads'
for id in "$@"; do
    echo $id
    if ! pgrep --full @${id} &> /dev/null ; then
        case $id in
        hell) eval "kitty --name @hell -o background=#04010F" &;;
        man) eval "kitty --name @man -o background=#04010F" &;;
        ranger) eval "kitty --name @ranger -e 'ranger -c ~/.config/ranger/rifle-new-window'" &;;
        gotop) eval "kitty --name @gotop -e 'gotop --rate=0.7'" &;;
        ?) eval "kitty --name @${id}" &;;
        esac
    fi
done
echo "Scratchpads launched"

kill_all()
{
    program=$1
    echo -n "Trying to kill $program"
    killall -q $program
    while pgrep -u $UID -x $program > /dev/null; do
        sleep 1
        echo -n '...'
    done
    echo -e "\nLaunching $program"
}

start_compton()
{
    kill_all compton
    compton --config ~/.config/compton/compton.conf &
    local last_exit="$?"
    if [[ $last_exit -ne '0' ]]; then
        echo "$0: couldn't launch compton"
    else
        echo 'compton launched'
    fi
}

start_polybar()
{
    kill_all polybar
    polybar satsu &
    local last_exit="$?"
    if [[ $last_exit -ne '0' ]]; then
        echo "$0: couldn't launch polybar"
    else
        echo 'Polybar launched'
    fi
}

start_systray()
{
    # doesn't kill them, only starts them
    for arg in "dunst -conf $HOME/.config/dunst/dunstrc" "copyq" "caffeine" #"wpa_gui -qt"
    do
        if ! ps ax | grep -v grep | grep -io "$arg" > /dev/null
        then
            echo "Launching $arg"
            exec /usr/bin/$arg &
        fi
    done
}

start_redshift()
{
    kill_all redshift
    redshift -x
    redshift -c ~/.config/redshift.conf &
    local last_exit="$?"
    if [[ $last_exit -ne '0' ]]; then
        echo "$0: couldn't launch redshift"
    else
        echo "Redshift launched"
    fi
}

functionlist=$'compton\npolybar\nsystray\nredshift'

if [[ -n $startall ]]; then
    for i in $functionlist; do
        eval "start_${i}"
    done
else
    prompt="Restart (Shift+Enter to select)"
    checklist=$(echo "$functionlist" | rofi -dmenu -multi-select -p "$prompt")
    for choice in $checklist; do
        echo "start_${choice}"
        eval "start_${choice}"
    done
fi

echo "=========Done========="
