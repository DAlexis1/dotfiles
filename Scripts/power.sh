#!/bin/bash

WIDTH=$(xrandr | fgrep '*' | awk '{print $1}' | tr "x" " " | awk '{print $1}')
HEIGTH=$(xrandr | fgrep '*' | awk '{print $1}' | tr "x" " " | awk '{print $2}')

power_window $WIDTH $HEIGTH
if [[ $? = "1" ]]; then
  poweroff
elif [[ $? = "2" ]]; then
  reboot
elif [[ $? = "3" ]]; then
  systemctl suspend
fi

exit 0
