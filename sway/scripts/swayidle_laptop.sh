#!/bin/bash

  #############################################
 #    Config                                 #
#############################################

### The time in minutes of inactivity required for activating swaylock.
#### LOCKSCREEN_IDLE=5


#The time in seconds when the display shuts down or machine suspends
AC_IDLE_TIMEOUT=900
BATT_IDLE_TIMEOUT=300

# Time in seconds to turn screens off after swaylock has been activated
TURN_SCREEN_OFF=10



  #############################################
 #    End of config                          #
#############################################

#rm /tmp/swayidlelog && echo `date` -- > /tmp/swayidlelog


# The location of swaylock script.
SWAYLOCK="~/.config/sway/scripts/swaylock.sh"
SUSPEND="~/.config/sway/scripts/suspend.sh"
VARIETY_RESUME="pgrep variety &> /dev/null && \
                variety --resume &> /dev/null"
VARIETY_PAUSE="pgrep variety &> /dev/null && \
                variety --pause &> /dev/null"

ON="swaymsg 'output * dpms on'"
AC="$HOME/.config/sway/scripts/ac"

# $AC && echo "AC True" >> /tmp/swayidlelog

##LSI_IN_SEC=$(($LOCKSCREEN_IDLE * 60)) 

swayidle  \
  timeout $TURN_SCREEN_OFF "pgrep swaylock && $SUSPEND" \
      resume "$ON" \
  timeout $AC_IDLE_TIMEOUT "swaymsg 'output * dpms off'; $VARIETY_PAUSE" \
      resume "$ON; $VARIETY_RESUME" \
  timeout $BATT_IDLE_TIMEOUT "$AC || $SWAYLOCK" \
      resume "$ON" \
  timeout $(($BATT_IDLE_TIMEOUT+$TURN_SCREEN_OFF)) "$SUSPEND" \
      resume "$ON" \
  before-sleep "$SWAYLOCK"
