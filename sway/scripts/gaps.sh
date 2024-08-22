#!/bin/bash
gaps=("11" "62" "72" "82" "92")
lrtb=("left" "right" "top" "bottom")
for i in ${gaps[@]}; do
  for x in ${lrtb[@]}; do
    echo swaymsg workspace $i gaps $x 0
  done
done
