#!/bin/bash

WIDTH=$(xwininfo -root | grep Width | awk '{print $2}')
HEIGHT=$(xwininfo -root | grep Height | awk '{print $2}')

power_window "${WIDTH}" "${HEIGHT}"
exit_code=$?
if [[ $exit_code -eq 1 ]]; then
  poweroff
elif [[ $exit_code -eq 2 ]]; then
  reboot
fi

exit 0
