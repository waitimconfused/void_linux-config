#!/bin/bash

path="$HOME/.config/polybar/"

echo "Killing polybars"
pkill polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

echo "Launching"

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
	echo "Launched polybar on monitor $m"
	MONITOR=$m polybar main -q &
done

echo "Bars launched"