#!/bin/bash

until [ "$(tailscale status --json | jq ".TailscaleIPs != null")" = "true" ]; do

	sleep 1

done

mount /mnt/tailscale
