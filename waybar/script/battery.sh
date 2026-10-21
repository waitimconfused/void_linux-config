#!/bin/bash

BAT_DIR="/sys/class/power_supply/BAT0"
AC_DIR="/sys/class/power_supply/AC"

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

	STATUS=$(cat $BAT_DIR/status)

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
		ac_connected=$(cat $AC_DIR/online)

		if [[ $ac_connected = "1" ]]; then
			message="$message$icon_charging "
		fi
		;;
	esac

	percentage=$(cat $BAT_DIR/capacity)

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

	icon="($MODE)"

	case $MODE in
	"performance/AC")
		icon="$tlp_PERFORMANCE"
		;;
	"balanced/BAT")
		icon="$tlp_BALANCED"
		;;
	"power-saver/SAV")
		icon="$tlp_POWERSAVER"
		;;
	*)
		icon="($MODE)"
		;;
	esac

	message="$message$icon</span>"

	thresh_start=$(cat "$BAT_DIR/charge_control_start_threshold")
	thresh_end=$(cat "$BAT_DIR/charge_control_end_threshold")

	charge_full=$(cat "$BAT_DIR/charge_full")
	charge_full_design=$(cat "$BAT_DIR/charge_full_design")

	max_percentage=$((100 * charge_full / charge_full_design))

	echo "{
		\"text\": \"$message\",
		\"alt\": \"\",
		\"tooltip\": \"BATTERY\n\nPercentage: $percentage% ($STATUS)\nState: $MODE $icBAT_DIRon\nMax Percentage: $max_percentage%\nCharge Threshold: [ $thresh_start% -> $thresh_end% ]\"
	}"
}

while true; do
	message="$(show)"
	echo $message

	sleep 1 &
	sleep_pid=$!
	wait

done
