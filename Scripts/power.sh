#!/bin/bash

#WIDTH=$(xwininfo -root | grep Width | awk '{print $2}')
#HEIGHT=$(xwininfo -root | grep Height | awk '{print $2}')
pos_x=$(xdotool getmouselocation | awk '{print $1}' | sed -e "s/x://g")
pos_y=$(xdotool getmouselocation | awk '{print $2}' | sed -e "s/y://g")
connected=$(xrandr | grep " connected " | sed -e "s/primary //g" | awk '{print $3}' | sed -e "s/x/+/g")
echo $pos_y
echo $pos_x
for screen_space in ${connected}; do
	echo $screen_space
	top_x=$(echo "${screen_space}" | awk -F "+" '{print $3}')
	top_y=$(echo "${screen_space}" | awk -F "+" '{print $4}')
	bottom_x=$(echo "${screen_space}" | awk -F "+" '{print expr $1 + $3}')
	bottom_y=$(echo "${screen_space}" | awk -F "+" '{print expr $2 + $4}')
	if [[ ${pos_x} -lt ${bottom_x} && ${pos_x} -gt ${top_x} && ${pos_y} -lt ${bottom_y} && ${pos_y} -gt ${top_y} ]]; then
		height=${bottom_y}
		width=${bottom_x}
		echo 1
	fi
done

power_window "${width}" "${height}"
exit_code=$?
if [[ $exit_code -eq 1 ]]; then
	poweroff
elif [[ $exit_code -eq 2 ]]; then
	reboot
fi

exit 0
