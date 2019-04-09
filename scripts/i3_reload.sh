#!/usr/bin/env bash


echo "=========RELOADING I3========="
xrdb ~/.Xresources

urxvt_options="-bg '#040008'"
# Launch scratchpads
echo 'Launching scratchpads'
for id in $@; do
    echo $id
    if ! pgrep --full @${id} &> /dev/null ; then
        case $id in
        hell) eval "urxvt -pe 'tabbed' $urxvt_options -name @hell" &;;
        man) eval "urxvt -pe 'tabbed' $urxvt_options -name @man" &;;# -fn "xft:Terminus:size=14" &;;
        ranger) eval "urxvt $urxvt_options -name @ranger -e 'ranger'" &;;#-fn "xft:Terminus:size=14" &;;
        gotop) eval "urxvt $urxvt_options -name @gotop -e 'gotop --rate=0.7'" &;;
        ?) eval "urxvt $urxvt_options -name @${id}" &;;
        esac
    fi
done
echo "Scratchpads launched"

#function l_compton
#{
#    echo -n "Trying to kill compton"
#    killall -q compton
#    while pgrep -u $UID -x compton > /dev/null
#    do
#        sleep 1
#        echo -n '...'
#    done
#    echo -e '\nLaunching compton...'
#    compton --config ~/.config/compton/compton.conf &
#    local last_exit="$?"
#    if [[ $last_exit -eq '124' ]]; then
#        echo "$0: couldn't launch compton"
#    else
#        echo 'compton launched'
#    fi
#}

function l_polybar
{
    # Terminate already running bar instances
    echo -n "Trying to kill polybar"
    killall -q polybar
    while pgrep -u $UID -x polybar > /dev/null
    do
        sleep 1
        echo -n '...'
    done
    echo -e '\nLaunching polybar...'
    polybar satsu &
    local last_exit="$?"
    if [[ $last_exit -eq '124' ]]; then
        echo "$0: couldn't launch polybar"
    else
        echo 'Polybar launched'
    fi
}

function l_systray
{
    # Start applets
    for arg in "dunst -conf /home/satsu/.config/dunst/dunstrc" "copyq" "caffeine" #"wpa_gui -qt"
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
    # Terminate already running redshift instances
    echo -n "Trying to kill redshift"
    killall -q redshift
    while pgrep -u $UID -x redshift > /dev/null
    do
        sleep 1
        echo -n '...'
    done
    redshift -x
    echo -e "\nLaunching redshift"
    redshift -c ~/.config/redshift.conf &
    local last_exit="$?"
    if [[ $last_exit -eq '124' ]]; then
        echo "$0: couldn't launch redshift"
    else
        echo "Redshift launched"
    fi
}

for i in l_compton l_polybar l_systray l_redshift; do
    ${i}
done

echo "=========Done========="
exit 0
