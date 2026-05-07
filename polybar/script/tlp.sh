#!/bin/bash

BATTERY="BAT1"

BATTERY_DIR="/sys/class/power_supply/$BATTERY"

message="%{F#4E7B31}"

STATUS=$( cat $BATTERY_DIR/status )

case $STATUS in
	"Discharging")
		;;
	"Not charging")
		message="$message󱥸 "
		;;
	"Charging")
		message="$message󱐋 "
		;;
	"Full")
		message="$message󱁖 "
		;;
esac



FULL=$( cat $BATTERY_DIR/charge_full )
NOW=$( cat $BATTERY_DIR/charge_now )

percentage=$( awk -v current=$NOW -v max=$FULL 'BEGIN { print int( current*100 / max +0.5 ) }'  )

if [[ $percentage -le 20 ]]; then
	message="$message "

elif [[ $percentage -le 40 ]]; then
	message="$message"

elif [[ $percentage -le 60 ]]; then
	# Yellow-ish
	message="$message"

elif [[ $percentage -le 80 ]]; then
	message="$message"

elif [[ $percentage -le 100 ]]; then
	message="$message"
fi

message="$message%{F-} $percentage%"



MODE=$( tlp-stat -m )

message="$message %{F#4E7B31}"

case $MODE in
	"performance/AC")
		message="$message󰚥"
		;;
	"balanced/BAT")
		message="$message󰗑"
		;;
	"power-saver/SAV")
		message="$message"
		;;
	*)
		message="$message($MODE)"
		;;
esac

message="$message%{F-}"

echo $message
