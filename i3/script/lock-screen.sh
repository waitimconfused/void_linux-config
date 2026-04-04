#!/bin/bash

i3lock -t \
	-i $HOME/Wallpapers/lock/Townscaper-Island.png \
	--clock \
	--time-str="%H:%M" \
	--time-color=FFFFFFFF \
	--time-font="JetBrains Mono:style=Bold" \
	--time-size=60 \
	--time-pos="x+w/2-170:y+h/2-160" \
	--time-size=60 \
	--date-str=""

monitors=$(xrandr | grep " connected " | awk '{ print $1 }')
monitors=($monitors)

monitor_count=${#monitors[@]}

if [[ $monitor_count = 1 ]]; then
	xset dpms force suspend
else
	echo "Only one monitor"
fi
