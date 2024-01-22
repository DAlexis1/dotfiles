#!/bin/bash

if [[ ! $# -eq 2 ]]; then
	echo "Usage : $0 flag value"
	exit 0
fi

module=$(ls /sys/class/backlight/)
max_brightness=$(cat "/sys/class/backlight/${module}/max_brightness")
actual_brightness=$(cat "/sys/class/backlight/${module}/brightness")

if [[ "$1" = "-d" ]]; then
	new_brightness=$(("${actual_brightness}" - "$2"))
elif [[ "$1" = "-u" ]]; then
	new_brightness=$(("${actual_brightness}" + "$2"))
else
	echo "Usage : $0 flag value"
	exit 0
fi

if [[ (${new_brightness} -le ${max_brightness}) && (${new_brightness} -gt 0) ]]; then
	echo "${new_brightness}" >>"/sys/class/backlight/${module}/brightness"
fi
exit 0
