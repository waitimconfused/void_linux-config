#!/bin/bash

BATTERY_DIR="/sys/class/power_supply/BAT0"
ACAD_DIR="/sys/class/power_supply/AC"

colour_background="#112717"
colour_foreground="#AAE8B6"
colour_primary="#4E7B31"
colour_alert="#BB334C"
colour_disabled="#2E462B"

icon_battery_0=""
icon_battery_1=""
icon_battery_2=""
icon_battery_3=""
icon_battery_4=""

icon_wait="󱥸"
icon_danger=""
icon_charging="󱐋"

tlp_PERFORMANCE="󰓅 "
tlp_BALANCED="󰾅 "
tlp_POWERSAVER="󰾆 "

show() {
	message="<span foreground='#4E7B31' size='large'>"

	STATUS=$(cat $BATTERY_DIR/status)

	case $STATUS in
	"Discharging")
		;;
	"Not charging")
		message="$message$icon_wait "
		;;
	"Charging")
		message="$message$icon_charging "
		;;
	"Full")
		ac_connected=$(cat $ACAD_DIR/online)

		if [[ $ac_connected = "1" ]]; then
			message="$message$icon_charging "
		fi
		;;
	esac

	percentage=$(cat $BATTERY_DIR/capacity)

	if [[ $percentage -le 20 ]]; then
		message="$message<span foreground='#BB334C'>$icon_danger</span> $icon_battery_0"

	elif [[ $percentage -le 40 ]]; then
		message="$message$icon_battery_1"

	elif [[ $percentage -le 60 ]]; then
		message="$message$icon_battery_2"

	elif [[ $percentage -le 80 ]]; then
		message="$message$icon_battery_3"

	elif [[ $percentage -le 100 ]]; then
		message="$message$icon_battery_4"
	fi

	message="$message</span>  $percentage%"

	if ! command -v tlp-stat >/dev/null 2>&1; then
		echo $message
		return
	fi

	MODE=$(tlp-stat -m)

	message="$message <span foreground='#4E7B31' size='large'>"

	case $MODE in
	"performance/AC")
		message="$message$tlp_PERFORMANCE"
		;;
	"balanced/BAT")
		message="$message$tlp_BALANCED"
		;;
	"power-saver/SAV")
		message="$message$tlp_POWERSAVER"
		;;
	*)
		message="$message($MODE)"
		;;
	esac

	message="$message</span>"

	echo $message

}

while true; do
	message="$(show)"
	echo $message

	sleep 1 &
	sleep_pid=$!
	wait

done
