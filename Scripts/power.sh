#!/bin/bash

WIDTH=$(xrandr | grep -F '*' | awk '{print $1}' | tr "x" " " | awk '{print $1}')
HEIGTH=$(xrandr | grep -F '*' | awk '{print $1}' | tr "x" " " | awk '{print $2}')

power_window $WIDTH $HEIGTH
exit_code=$?
if [[ $exit_code -eq 1 ]]; then
  poweroff
elif [[ $exit_code -eq 2 ]]; then
  reboot
fi

exit 0
