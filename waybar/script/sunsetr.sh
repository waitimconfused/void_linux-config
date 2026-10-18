#!/bin/bash

sunsetr status --json --follow | while IFS= read -r data; do
	JSON=$(
		echo $data | jq --compact-output \
			'if .event_type == "preset_changed" then
				{
					text: .to_preset // "default",
					alt: .to_preset // "default",
					tooltip: "SUNSETR\n\nPreset: \(.to_preset // "default")"
				}
			elif .event_type == "state_applied" then
				{
					text: .active_preset,
					alt: .active_preset,
					tooltip: "SUNSETR\n\nPreset: \(.active_preset)\nTemp: \(.current_temp)K @ \(.current_gamma)%\nPeriod: \(.period)"
				}
			else
				empty
			end'
	)

	if [[ "$JSON" != "" ]]; then
		echo $JSON
	fi
done