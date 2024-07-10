#!/bin/bash
function show_color() {
    perl -e 'foreach $a(@ARGV){print "\e[48:2::".join(":",unpack("C*",pack("H*",$a)))."m  \e[49m "};print "\n"' "$@"
}

echo "Foreground"
show_color "{{foreground}}"
echo "Background"
show_color "{{background}}"
echo "Cursor"
show_color "{{cursor}}"

echo " 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15"
show_color \
"{{color0}}" \
"{{color1}}" \
"{{color2}}" \
"{{color3}}" \
"{{color4}}" \
"{{color5}}" \
"{{color6}}" \
"{{color7}}" \
"{{color8}}" \
"{{color9}}" \
"{{color10}}" \
"{{color11}}" \
"{{color12}}" \
"{{color13}}" \
"{{color14}}" \
"{{color15}}"

