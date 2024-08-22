#!/bin/bash
sway_output=`swaymsg -t get_tree | jq -r '.. | select(.type?) | select(.focused == true)| .name, .fullscreen_mode'`
fullscreen=`echo $sway_output | tail -c 2`
#is_youtube=

[[ "$fullscreen" == "1" ]] && (swaymsg exec wtype f; exit 0)
#swaymsg -t get_tree | jq -r '.. | select(.type?) | select(.focused == true)| .window_properties.title' i
echo $sway_output | grep -i youtube && 
(swaymsg exec wtype f; sleep .2;
swaymsg fullscreen)
