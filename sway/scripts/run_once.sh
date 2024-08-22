#!/bin/bash

#
# Start applications if not running.
#

rmcomments() {
# remove comments
	a=$@
        echo ${a%#*}
}

while read line; do
  line="${line/\$HOME/$HOME}"
  line=$(rmcomments "$line")
  [ "$line" == "" ] && continue
  bname=$(basename $line)
  pgrep $bname > /dev/null || $line &
done < $HOME/.config/sway/autorun

