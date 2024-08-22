#!/bin/bash
echo `date` swaylock called $@
echo `date` swaylock called "$@" >> /tmp/swayidlelog
# Exit if swaylock is already running
pgrep swaylock -x &> /dev/null && exit 0

for i in $@
do
    case "$i" in
        swayidle)
            SWAYIDLE=true
            ;;
        grace=*)
            GRACE=${i#*=}
            ;;
        *)
            # Placeholder
            ;;
    esac
    shift
done
GRACE=${grace-1}
$HOME/.config/sway/scripts/ac && [ "$SWAYIDLE" == "true" ] && exit 0

[[ $GRACE = 1 ]] && FADE_TIME=15 || FADE_TIME=5

pgrep variety &> /dev/null && variety --pause &> /dev/null

$HOME/.config/sway/bin/swaylock \
  --daemonize \
  --image ~/.cache/current_wallpaper.jpg \
  --clock \
  --indicator-radius 200 \
  --indicator-thickness 10 \
  --ring-color bb00cc \
  --key-hl-color 880033 \
  --line-color 00000000 \
  --inside-color 00000088 \
  --inside-clear-color 00f60088 \
  --inside-ver-color 00060088 \
  --inside-wrong-color 60000088 \
  --separator-color 00000000 \
  --grace $GRACE \
  --fade-in=2 \
  --effect-vignette .5:.2 \
  --effect-blur 4x1 \
  --text-wrong "A-a-aaa you didn't say the magic word!" 
