#!/bin/bash
swaymsg="/usr/bin/swaymsg --socket /run/user/1000/sway-ipc.1000.1600.sock"



lines="first line\nsecond line\nthird line" 
TREE=`$swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select(.pid and .visible) | "\(.id) \(.focused)"'`




DIRECTION=FORWARD
FIRST=
LAST=
FOCUS=
while read id focused
do
  [ -z "FOCUS" ] && echo "previous was focus"
  [ "$focused" == "true" ] && (FOCUS=True; echo "found focus")
  echo $id $focused
done <<< "$(echo -e "$TREE")"









exit

$swaymsg -t get_tree | jq -r '.. | (.nodes? // empty)[] | select(.pid and .visible) | "\(.id) \(.focused)"' | \
while read -r id focused; do
  FIRST="yes"
  echo ID: $id Focused: $focused
done
echo FIRST
