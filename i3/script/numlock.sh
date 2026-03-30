#!/bin/bash

current_state=$(xset q | grep Caps | cut -d " " -f20)

case $1 in
	on)
		echo "Turning Num_Lock ON (numbers)."
		;;
	off)
		echo "Turning Num_Lock OFF (arrows)."
		;;
	*)
		echo "Unknown State '$current_state'; Expected 'on' or 'off'."
		exit 0
		;;
esac

if [[ $current_state != $1 ]]; then
	xdotool key --clearmodifiers Num_Lock
	echo "New state set."
else
	echo "State already set."
fi
