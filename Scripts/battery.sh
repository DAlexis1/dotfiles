#!/bin/bash

BAT=$(acpi -b | awk '{print $4}')
BAT=${BAT%,}

# Full and short texts
if [[ $(acpi -b | awk '{print $3}') = "Full," ]]; then
	echo "Full"
	echo "Full"
elif [[ $(acpi -b | awk '{print $3}') = "Discharging," ]]; then
	echo "  $BAT"
	echo "  $BAT"
elif [[ $(acpi -b | awk '{print $3}') = "Not" ]]; then
	# when charging the output for the state of the battery may be bugged and be two words so we need to move it
	BAT=$(acpi -b | awk '{print $5}')
	echo "󱊦 $BAT"
	echo "󱊦 $BAT"
elif [[ $(acpi -b | awk '{print $3}') = "Charging," ]]; then
	# when charging the output for the state of the battery may be bugged and be two words so we need to move it
	echo "󱊦 $BAT"
	echo "󱊦 $BAT"

fi

#Set orange color below 5% or use orange below 20%
[ ${BAT%?} -le 5 ] && echo "#FF0000" && exit 0
[ ${BAT%?} -le 20 ] && echo "#FF8000"

exit 0
