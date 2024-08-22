#!/bin/bash
killall aosd_cat
echo -ne "$@" | aosd_cat -f 500 -n 'Nerd Font Mono 60' -R '#97fc6c' -p 4 -o 1000 -u 2000
