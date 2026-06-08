#!/bin/bash

BATTERY_DIR="/sys/class/power_supply/BAT1"
ACAD_DIR="/sys/class/power_supply/ACAD"

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

icon_danger=""
icon_charging="󱐋"

tlp_AC="󰚥"
tlp_BAT="󰗑"
tlp_SAV="󰩪"


message="%{F$colour_primary}"

STATUS=$( cat $BATTERY_DIR/status )

case $STATUS in
	"Discharging")
		;;
	"Not charging")
		message="$message󱥸 "
		;;
	"Charging")
		message="$message$icon_charging "
		;;
	"Full")
		ac_connected=$( cat $ACAD_DIR/online )

		if [[ $ac_connected = "1" ]]; then
			message="$message$icon_charging "
		fi
		;;
esac


percentage=$(cat $BATTERY_DIR/capacity)

if [[ $percentage -le 20 ]]; then
	message="$message%{F$colour_alert}$icon_danger%{F$colour_primary} $icon_battery_0"

elif [[ $percentage -le 40 ]]; then
	message="$message$icon_battery_1"

elif [[ $percentage -le 60 ]]; then
	message="$message$icon_battery_2"

elif [[ $percentage -le 80 ]]; then
	message="$message$icon_battery_3"

elif [[ $percentage -le 100 ]]; then
	message="$message$icon_battery_4"
fi

message="$message%{F-} $percentage%"


if ! command -v tlp-stat >/dev/null 2>&1; then
	echo $message
	exit 0
fi


MODE=$( tlp-stat -m )

message="$message %{F$colour_primary}"

case $MODE in
	"performance/AC")
		message="$message$tlp_AC"
		;;
	"balanced/BAT")
		message="$message$tlp_BAT"
		;;
	"power-saver/SAV")
		message="$message$tlp_SAV"
		;;
	*)
		message="$message($MODE)"
		;;
esac

message="$message%{F-}"

echo $message
