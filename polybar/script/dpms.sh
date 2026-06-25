#!/bin/bash

FILE="$HOME/.config/polybar/script/cache/dpms"

if [ ! -f "$FILE" ]; then
	echo "sleep" > $FILE
fi

t=0

case "$(< $FILE)" in
	"sleep")
		t=0
		;;
	"no-sleep")
		t=1
		;;
	*)
		echo "Unknown custom/dpms state: \"$(< $FILE)\". Expected \"sleep\" or \"no-sleep\"."
		exit
esac

if [[ "$(< $FILE)" = "sleep" ]]; then
	t=0
else
	t=1
fi

sleep_pid=0
colour="%{F#4E7B31}"

if [[ "$t" = "0" ]]; then
	eval "xset dpms 70 100 160"
	eval "xset s 60 0"
	echo "${colour}󰒲%{F-}"
else
	eval "xset dpms 0 0 0"
	eval "xset s 0 0"
	echo "${colour}󰒳%{F-}"
fi

click() {
	t=$(((t + 1) % 2))

	if [[ "$t" = "0" ]]; then
		echo "sleep" > $FILE
	else
		echo "no-sleep" > $FILE
	fi

	if [ $t -eq 0 ]; then
		eval "xset dpms 70 100 160"
		eval "xset s 60 0"
		echo "${colour}󰒲%{F-}"
	else
		eval "xset dpms 0 0 0"
		eval "xset s 0 0"
		echo "${colour}󰒳%{F-}"
	fi

	if [ "$sleep_pid" -ne 0 ]; then
		kill $sleep_pid >/dev/null 2>&1
	fi
}

trap "click" USR1

while true; do
	duration=5

	sleep $duration &
	sleep_pid=$!
	wait
done
