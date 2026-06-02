#!/bin/bash

path="$HOME/.config/polybar/"

echo "Killing polybars"
pkill polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

echo "Launching"

for m in $(xrandr --listactivemonitors | grep "  " | cut -d" " -f6); do
	echo "Launched polybar on monitor $m"
	MONITOR=$m polybar main --quiet &
done

echo "Bars launched"
