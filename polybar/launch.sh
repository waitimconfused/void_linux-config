#!/bin/bash

path="$HOME/.config/polybar."

# When running script, kill the previous `inotifywait` listener, and continue
prev_pid=$(ps -ef | grep "inotifywait -e modify $path --recursive" | grep -v "grep" | cut -d " " -f3)
kill -9 $prev_pid

launch() {
	echo "Killing polybars"
	pkill polybar

	while pgrep -x polybar >/dev/null; do sleep 1; done

	echo "Launching"

	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		echo "Launched polybar on monitor $m"
		MONITOR=$m polybar main -q &
	done

	echo "Bars launched"
}

launch

# Listen for changes to polybar config files and relaunch
while inotifywait -e modify $path --recursive; do
	echo "Detected changes to $HOME/.config/polybar"
	launch
done