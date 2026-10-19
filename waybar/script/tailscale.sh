#!/bin/bash

colour_background="#112717"
colour_foreground="#AAE8B6"
colour_primary="#4E7B31"
colour_alert="#BB334C"
colour_disabled="#2E462B"

show() {
	status=$(tailscale status --self --json)

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
	
	host_name=$(echo $status | jq --raw-output '.Self.HostName')
	host_ipv4=$(echo $status | jq --raw-output ".Self.TailscaleIPs[0]")
	host_ipv6=$(echo $status | jq --raw-output ".Self.TailscaleIPs[1]")

	exit_node_id="$(echo $status | jq --raw-output ".ExitNodeStatus.ID")"
	exit_node_name="(none)"
	if [ "$exit_node_id" != "null" ]; then
		exit_node_name="$(echo $status | jq --raw-output ".Peer[] | select(.ID==\"$exit_node_id\") | .DNSName | split(\".\")[0]")"
	fi


	if [ "$network_name" = "_LOGIN" ]; then
		echo "{\
				\"text\": \"\",\
				\"tooltip\": \"\"\
			}"
		return
	fi

	string="<span foreground='#4E7B31' size='large'> </span> $network_name"

	echo "{
		\"text\": \"$string\",
		\"tooltip\": \"TAILSCALE\n\nNetwork: $network_name\n\nHost: $host_name\nIPv4: $host_ipv4\n\nExit Node: $exit_node_name\"
	}"
}

trap "show" USR1

while true; do
	message="$(show)"
	echo $message

	sleep 1 &
	sleep_pid=$!
	wait
done
