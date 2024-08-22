#!/bin/bash
swaymsg -t get_tree |   jq -r 'recurse(.nodes[]?) | select(.name == "__i3_scratch").floating_nodes[].app_id, select(.name == "__i3_scratch").floating_nodes[].window_properties.title' | grep -v null
exit
swaymsg -t get_tree |

jq -r '.nodes[].nodes[] | if .nodes then [recurse(.nodes[])] else [] end + .floating_nodes | .[] | select(.nodes==[]) | ((.id | tostring) + "\t" + .name)' |

rofi -dmenu -config ~/.config/rofi/leftbottom | {

read -r id name

swaymsg "[con_id=$id]" focus

}
