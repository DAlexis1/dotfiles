#!/bin/bash

# BAT=$(acpi -b | awk '{print $4}')
# BAT=${BAT%,}

BAT="$(cat /sys/class/power_supply/BAT0/capacity)%"

status=$(cat "/sys/class/power_supply/BAT0/status")

# Full and short texts
if [[ "${status}" = "Full" ]]; then
	echo "Full"
	echo "Full"
elif [[ "${status}" = "Discharging" ]]; then
	echo "  $BAT"
	echo "  $BAT"
elif [[ "${status}" = "Not" ]]; then
	# when charging the output for the state of the battery may be bugged and be two words so we need to move it
	echo "󱊦 $BAT"
	echo "󱊦 $BAT"
elif [[ "${status}" = "Charging" ]]; then
	# when charging the output for the state of the battery may be bugged and be two words so we need to move it
	echo "󱊦 $BAT"
	echo "󱊦 $BAT"
fi

#Set orange color below 5% or use orange below 20%
[ ${BAT%?} -le 5 ] && echo "#FF0000" && exit 0
[ ${BAT%?} -le 20 ] && echo "#FF8000"

exit 0
