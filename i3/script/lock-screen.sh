#!/bin/bash

. $HOME/.config/i3/script/numlock.sh on

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

