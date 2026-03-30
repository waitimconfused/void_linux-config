#!/bin/bash

value_location="$HOME/.config/i3/script/stored_data/nightlight-value"

on_value="1.0:0.88:0.76"
off_value="1:1:1"

set_gamma() {

	echo "  Gamma: $1"

	for display in $(xrandr | grep " connected" | cut -d " " -f1); do
		xrandr --output $display --gamma $1
		echo "  Set gamma on display '$display'."
	done

}

case $1 in
	on)
		echo "Turning nightlight ON"
		set_gamma $on_value
		;;
	off)
		echo "Turning nightlight OFF"
		set_gamma $off_value
		;;
	toggle)
		echo "Reading last nightlight state from '$value_location' ($( < "$value_location" ))"
		value=$(< "$value_location")
		case $value in
			on)
				echo "Toggling nightlight OFF"
				set_gamma $off_value
				echo "off" > "$value_location"
				;;
			off)
				echo "Toggling nightlight ON"
				set_gamma $on_value
				echo "on" > "$value_location"
				;;
			*)
				echo "Unknown stored value '$value'. Exiting."
				;;
		esac
		exit 0
		;;

	*)
		echo "Unknown parameter '$1'; Expected 'on', 'off', or 'toggle'. Reloading state instead."
		echo "Reloading nightlight state from '$value_location' ($( < "$value_location" ))"
		value=$(< "$value_location")
		
		case $value in
			on)
				set_gamma $on_value
				;;
			off)
				set_gamma $off_value
				;;
			*)
				echo "Unknown stored value '$value'. Exiting."
				;;
		esac

		exit 0

		;;
esac

echo $1 > "$value_location"
