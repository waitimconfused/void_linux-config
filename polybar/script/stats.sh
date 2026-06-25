#!/bin/bash

FILE="$HOME/.config/polybar/script/cache/stats"

if [ ! -f "$FILE" ]; then
	echo "cpu" > $FILE
fi

t=0

case "$(< $FILE)" in
	"cpu")
		t=0
		;;
	"ram")
		t=1
		;;
	*)
		echo "Unknown custom/stats state: \"$(< $FILE)\". Expected \"cpu\" or \"ram\"."
		exit
esac

sleep_pid=0
colour="%{F#4E7B31}"

click() {
	t=$(((t + 1) % 2))

	echo $t > $FILE

	if [ $t -eq 0 ]; then
		echo "${colour}%{F-} XX%"
		echo "cpu" > $FILE
	else
		echo "${colour}%{F-} XX%"
		echo "ram" > $FILE
	fi

	show

	if [ "$sleep_pid" -ne 0 ]; then
		kill $sleep_pid >/dev/null 2>&1
	fi
}

trap "click" USR1

show() {
	if [ $t -eq 0 ]; then
		p=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print int(100 - $1)"%"}')
		echo "${colour}%{F-} ${p}"
	else
		p=$(free -m | awk 'NR==2{printf "%i%", int($3*100/$2) }')
		echo "${colour}%{F-} ${p}"
	fi
}

while true; do
	show

	duration=5

	sleep $duration &
	sleep_pid=$!
	wait
done
