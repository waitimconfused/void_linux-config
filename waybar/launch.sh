#!/bin/bash

shopt -s globstar

CONFIG_DIR="$HOME/.config/waybar"

trap "pkill waybar" EXITp

while true; do

	echo "Launching polybar"
	waybar &>/dev/null &

	echo "Waiting for config changes"
	inotifywait \
		"$CONFIG_DIR/" \
		--exclude 'launch\.sh|cache/|4913' \
		--recursive \
		--event create,modify,delete

	echo "Killing Waybar (& scripts)"
	pkill waybar

	for filename in $CONFIG_DIR/script/**/*.sh; do
		pkill -f "/bin/bash $filename"
		pkill -f "/bin/sh $filename"
		echo "- Killing $filename"
	done

done
