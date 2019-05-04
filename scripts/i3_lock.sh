#!/usr/bin/env bash

function revert
{
	xset dpms 70 120 300
}

#trap revert HUP INT TERM
xset +dpms dpms 15 20 20

# Mute audio
#if amixer get Master | egrep '\[on\]$' | grep Playback; then
#	 amixer set Master toggle
#fi

i3lock --show-failed-attempts --ignore-empty-password --blur=10 --clock --timecolor=ffffffff --datecolor=ffffffff --wrongtext=">:C"

revert
