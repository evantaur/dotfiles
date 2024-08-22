#!/bin/bash
echo `date` suspend called "$@" >> /tmp/swayidlelog
echo `date` suspend called "$@"
VARIETY_PAUSE='pgrep variety &> /dev/null && variety --pause &> /dev/null'

for i in $@
do
    case "$i" in
        SLEEP)
            SLEEP=true
            ;;
        AC)
            swaymsg "output * dpms off"
            swaymsg "exec '$VARIETY_PAUSE'"
            exit 0
            ;;
        BATT)
            ./ac || (swaymsg "output * dpms off" &&  \
                     swaymsg 'exec ~/.config/sway/scripts/swaylock.sh' && \
                     swaymsg "exec '$VARIETY_PAUSE'")
            exit 0
            ;;
        *)
            # Placeholder
            ;;
    esac
    shift
done




if [ "$SLEEP" != "true" ]; then
  pgrep swaylock &> /dev/null|| exit 0
fi


swaymsg "exec '$VARIETY_PAUSE'"
~/.config/sway/scripts/ac && \
swaymsg "output * dpms off" || systemctl suspend
