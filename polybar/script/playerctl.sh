#!/bin/bash
status="$(playerctl status)"

show() {
	status="$(playerctl status)"

	if [ "$status" = "" ]; then
		echo ""
		exit 0
	fi

	reload="kill -USR1 $$"

	playbutton="%{A:playerctl play-pause & $reload:}"

	if [ "$status" = "Paused" ]; then
		playbutton="$playbutton"
	else
		playbutton="$playbutton"
	fi

	playbutton="$playbutton%{A}"

	info="%{A:kill -USR1 $$:}"

	icon="%{F#4E7B31}󰎇%{F-}"
	echo "$icon %{A:playerctl previous & $reload:}󰒮%{A} $playbutton %{A:playerctl next & $reload:}󰒭%{A} $info"

}

trap "show" USR1

while true; do
	message="$(show)"
	echo $message

	sleep 1 &
	sleep_pid=$!
	wait
done
