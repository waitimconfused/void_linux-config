#!/bin/bash

single_monitor=$( niri msg --json outputs | jq "keys | length == 1" )

if [[ "$single_monitor" = "true" ]]; then
	stasis trigger lock_screen &&
	stasis trigger dpms &&
	stasis trigger suspend
fi
