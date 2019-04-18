#!/usr/bin/env bash

echo "=========RELOADING I3========="
xrdb ~/.Xresources

# when starting i3 for the first time
if [[ $1 == 'start' ]]; then
    startall='true'
    shift
fi

urxvt_color="-bg '#040008'"
echo 'Launching scratchpads'
for id in $@; do
    echo $id
    if ! pgrep --full @${id} &> /dev/null ; then
        case $id in
        hell) eval "urxvt -pe 'tabbed' $urxvt_color -name @hell" &;;
        man) eval "urxvt -pe 'tabbed' $urxvt_color -name @man  -fn 'xft:Terminus:size=10'" &;;
        ranger) eval "urxvt $urxvt_color -name @ranger -e 'ranger'" &;;
        gotop) eval "urxvt $urxvt_color -name @gotop -e 'gotop --rate=0.7'" &;;
        ?) eval "urxvt $urxvt_color -name @${id}" &;;
        esac
    fi
done
echo "Scratchpads launched"

function wait_for
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

function l_compton
{
    wait_for compton
    compton --config ~/.config/compton/compton.conf &
    local last_exit="$?"
    if [[ $last_exit -ne '0' ]]; then
        echo "$0: couldn't launch compton"
    else
        echo 'compton launched'
    fi
}

function l_polybar
{
    wait_for polybar
    polybar satsu &
    local last_exit="$?"
    if [[ $last_exit -ne '0' ]]; then
        echo "$0: couldn't launch polybar"
    else
        echo 'Polybar launched'
    fi
}

function l_systray
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

function l_redshift
{
    wait_for redshift
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
        eval "l_${i}"
    done
else
    prompt="Restart (Shift+Enter to select)"
    checklist=$(echo "$functionlist" | rofi -dmenu -multi-select -p "$prompt")
    for choice in $checklist; do
        echo "l_${choice}"
        eval "l_${choice}"
    done
fi

echo "=========Done========="
