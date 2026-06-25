#!/bin/bash

is_locked=$(ps -ef | grep -v grep | grep i3lock)

if [[ $is_locked != "" ]]; then
	echo "Device is already locked"
	exit 0
fi

. $HOME/.config/i3/script/numlock.sh on

i3lock \
	--image=$HOME/Wallpapers/lock/Townscaper-Island.png \
	--fill \
	--clock \
	--time-str="%H:%M" \
	--time-color=FFFFFFFF \
	--time-font="JetBrains Mono:style=Bold" \
	--time-size=60 \
	--time-pos="x+w/2-170:y+h/2-160" \
	--time-size=60 \
	--date-str="" \
	--ignore-empty-password \
	--pass-media-keys

