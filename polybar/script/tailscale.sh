#!/bin/sh

show() {
	status=$(tailscale status --self --json)

	string=""

	reload="kill -USR1 $$"

	# bail out if curl had non-zero exit code
	if [ $? != 0 ]; then
		string="${string} %{A:echo xdg-open https://login.tailscale.com & $reload:}%{A}"
		echo $string
		exit 0
	fi

	# check if it's stopped (down)
	if [ "$(echo ${status} | jq --raw-output .BackendState)" = "Stopped" ]; then
		string="${string}%{A:tailscale up & $reload:}%{A}"
		echo $string
		exit 0
	fi

	string="${string}%{A:tailscale down & $reload:}%{A}"

	exit_node_id="$(echo $status | jq --raw-output ".ExitNodeStatus.ID")"

	if [ "${exit_node_id}" != "null" ]; then
		exit_node_hostname="$(echo $status | jq --raw-output ".Peer[] | select(.ID==\"${exit_node_id}\") | .DNSName | split(\".\")[0]")"
		string="${string} %{A:tailscale set --exit-node='' & $reload:} ${exit_node_hostname}%{A}"
	else
		string="${string} %{A:tailscale set --exit-node='k-server' & $reload:}%{A}"
	fi

	echo $string
}

trap "show" USR1

while true; do
	message="$(show)"
	echo $message

	sleep 1 &
	sleep_pid=$!
	wait

done
