#!/bin/bash

wifi_list=$(nmcli dev wifi | less | sed "s/*/ /g" | awk -F "  " '{print $6}' | sort | uniq | sed -e "s/ /#/g" | sed -e "s/\n/ /g")
#echo "${wifi_list}"
Connect=$(zenity --list --title "Connection Manager" --text="Choose a network" --column "Wifi List" ${wifi_list})
Connect=${Connect/'#'/" "}
echo "${Connect}"
if nmcli dev wifi connect "${Connect}"; then
	zenity --info --text "You're now connected to ${Connect}"
elif [[ "$Connect" != "" ]]; then
	zenity --info --text "Failed to connect to ${Connect}"
fi
