#!/bin/bash

  #############################################
 #    Config                                 #
#############################################

AC_IDLE_TIMEOUT=900
TURN_SCREEN_OFF=10
RGB_IDLE="/usr/bin/openrgb -d 1 -m static -b 2 -c purple > /dev/null"
RGB_RESUME="/usr/bin/openrgb -d 1 -m static -b 25 -c purple > /dev/null"
  #############################################
 #    End of config                          #
#############################################

# The location of swaylock script.
SWAYLOCK="~/.config/sway/scripts/swaylock.sh"
SUSPEND="~/.config/sway/scripts/suspend.sh"
VARIETY_RESUME="pgrep variety &> /dev/null && \
                variety --resume &> /dev/null"
VARIETY_PAUSE="pgrep variety &> /dev/null && \
                variety --pause &> /dev/null"

isFullscreen="$HOME/.config/sway/scripts/isFullscreen"
ON="swaymsg 'output * dpms on'"
AC="$HOME/.config/sway/scripts/ac"
HA_IDLE="$HOME/scripts/idletoggle.sh"

# $AC && echo "AC True" >> /tmp/swayidlelog

##LSI_IN_SEC=$(($LOCKSCREEN_IDLE * 60)) 

swayidle  \
  timeout 5 "date +%s > /tmp/swayidle" \
      resume "$HA_IDLE true; $ON; echo '' > /tmp/swayidle" \
  timeout $TURN_SCREEN_OFF "pgrep swaylock && swaymsg 'output * dpms off'" \
      resume "$ON" \
  timeout $AC_IDLE_TIMEOUT "$isFullscreen || (swaymsg 'output * dpms off'; $VARIETY_PAUSE; $RGB_IDLE)" \
      resume "$ON; $VARIETY_RESUME; $RGB_RESUME" \
  timeout $(($AC_IDLE_TIMEOUT*2)) "$SWAYLOCK; systemctl suspend" \
      resume "$ON; $VARIETY_RESUME" \
  after-resume "$ON" \
  before-sleep "$HA_IDLE false; $SWAYLOCK"
  
