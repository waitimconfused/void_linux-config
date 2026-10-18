#!/bin/sh

colour_background="#112717"
colour_foreground="#AAE8B6"
colour_primary="#4E7B31"
colour_alert="#BB334C"
colour_disabled="#2E462B"

show() {
	status=$(tailscale status --self --json)

	reload="kill -USR1 $$"

	if [ $? != 0 ]; then
		echo "{\
				\"text\": \"\",\
				\"tooltip\": \"\"\
			}"
		return
	fi

	if [ "$(echo $status | jq --raw-output .BackendState)" = "Stopped" ]; then
		echo "{\
				\"text\": \"\",\
				\"tooltip\": \"\"\
			}"
		return
	fi

	network_name=$(echo $status | jq --raw-output '.Self?.CapMap | if has("tailnet-display-name") then .["tailnet-display-name"] | join(", ") else "_LOGIN" end')

	if [ "$network_name" = "_LOGIN" ]; then
		echo "{\
				\"text\": \"\",\
				\"tooltip\": \"\"\
			}"
		return
	fi

	string="<span foreground='#4E7B31' size='large'> </span> $network_name"

	tooltip="Tailnet: $network_name"

	echo "{\
			\"text\": \"$string\",\
			\"tooltip\": \"$tooltip\"\
		}"
}

trap "show" USR1

while true; do
	echo $(show)

	sleep 1 &
	sleep_pid=$!
	wait
done
