#!/bin/bash

# See: "brightnessctl --list"
DEVICE="dell::kbd_backlight"

brightness=$(brightnessctl --device="$DEVICE" get)

new_brightness=$(((brightness + 1) % 3))

echo "$brightness -> $new_brightness"

brightnessctl --device="$DEVICE" set $new_brightness
