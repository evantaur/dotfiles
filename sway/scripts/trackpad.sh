#!/bin/bash
set +o noclobber
TPSTATUSFILE='/tmp/.swaytrackpadstatus'
# echo "$TPSTAUTSFILE"
[ -f $TPSTATUSFILE ] || echo $1 > $TPSTATUSFILE

STATUS=`cat $TPSTATUSFILE`
INPUT_CMD="input type:touchpad events"

echo $STATUS
if [ "$STATUS" == "enabled" ]; then
    echo disabled > "$TPSTATUSFILE"
    swaymsg "$INPUT_CMD disabled"
    swaymsg 'exec $HOME/.config/sway/scripts/osd.sh "Trackpad Disabled"'
    swaymsg seat - cursor set 10000 10000
else
    echo enabled > "$TPSTATUSFILE"
    swaymsg "$INPUT_CMD enabled"
    swaymsg 'exec $HOME/.config/sway/scripts/osd.sh "Trackpad Enabled"'
fi
