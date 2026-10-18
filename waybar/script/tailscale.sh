#!/bin/sh

colour_background="#112717"
colour_foreground="#AAE8B6"
colour_primary="#4E7B31"
colour_alert="#BB334C"
colour_disabled="#2E462B"

echo "A"

show() {
	status=$(tailscale status --self --json)

	string="<big></big>"

	reload="kill -USR1 $$"

	# bail out if curl had non-zero exit code
	if [ $? != 0 ]; then
		# string="${string} <a href=''></a>%{A:echo xdg-open https://login.tailscale.com & $reload:}%{A}"
		string="${string}"
		echo $string
		return
	fi

	# check if it's stopped (down)
	if [ "$(echo $status | jq --raw-output .BackendState)" = "Stopped" ]; then
		# string="$string%{A:tailscale up & $reload:}%{A}"
		string="$string%"
		echo $string
		return
	fi

	network_name=$(echo $status | jq --raw-output '.Self?.CapMap | if has("tailnet-display-name") then .["tailnet-display-name"] | join(", ") else "_LOGIN" end')

	if [ "$network_name" = "_LOGIN" ]; then
		string="$string"
		echo $string
		return
	fi

	# string="$string %{A:tailscale down & $reload:}$network_name %{A}"
	# string="$string $network_name "
	string="$string <span foreground='#4E7B31' size='large'> </span> $network_name"

	exit_node_id="$(echo $status | jq --raw-output ".ExitNodeStatus.ID")"

	if [ "$exit_node_id" != "null" ]; then
		exit_node_name="$(echo $status | jq --raw-output ".Peer[] | select(.ID==\"$exit_node_id\") | .DNSName | split(\".\")[0]")"
		# string="$string %{A:tailscale set --exit-node='' & $reload:} $exit_node_name%{A}"
		# string="$string  $exit_node_name"
		string="$string  (󰾋 $exit_node_name)"
	# else
		# string="$string %{A:tailscale set --exit-node='k-server' & $reload:}%{A}"
		# string="$string "
	fi

	tooltip="<big>$network_name</big>"

	echo "{\
			\"text\": \"$string\",\
			\"tooltip\": \"$tooltip\",\
		}"
}

trap "show" USR1

while true; do
	echo $(show)

	sleep 1 &
	sleep_pid=$!
	wait
done
