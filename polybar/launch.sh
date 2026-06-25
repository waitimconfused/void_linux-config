#!/bin/bash

path="$HOME/.config/polybar"

echo "Killing polybars"
pkill polybar

config_path="$path/script/cache"
if [[ ! -e $config_path ]]; then
	echo "Creating script/cache folder"
	mkdir $config_path
fi

if [[ ! -e "$config_path/dpms" ]]; then
	echo "Setting \"custom/dpms\" cache file to \"sleep\""
	echo "sleep" > "$config_path/dpms"
fi

if [[ ! -e "$config_path/stats" ]]; then
	echo "Setting \"custom/stats\" cache file to 0"
	echo "cpu" > "$config_path/stats"
fi

while pgrep -x polybar >/dev/null; do sleep 1; done

echo "Launching"

for m in $(xrandr --listactivemonitors | grep "  " | cut -d" " -f6); do
	echo "Launched polybar on monitor $m"
	MONITOR=$m polybar main --quiet &
done

echo "Bars launched"
