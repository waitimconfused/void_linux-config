#!/usr/bin/env bash

echo "Killing polybars"
pkill polybar

while pgrep -x polybar >/dev/null; do sleep 1; done

echo "Launching"

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  echo "Launched polybar on monitor $m"
  MONITOR=$m polybar main -q &
done


# polybar example 2>&1 | tee -a /tmp/polybar1.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched"
