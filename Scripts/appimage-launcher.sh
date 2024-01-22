#!/bin/bash

config_file=$(find / | grep "AppImage/.config" | head -n 1)
default_user=$(cat "${config_file}" | grep "default_user" | sed -e "s/default_user=//g")

list_app_image=$(ls "/home/${default_user}/AppImage" | sed -e "s/.AppImage//g" | sed -e "s/\n/ /g")
list_flatpak=$(ls "/home/${default_user}/Flatpak" | sed -e "s/\n/ /g")
selector=$(zenity --list --title "Launcher" --text "Choose between AppImage or Flatpak launcher" --column "Choice" AppImage Flatpak)
if [[ "${selector}" = "AppImage" ]]; then
	launch_app=$(zenity --list --title "Appimage launcher" --text "Choose an AppImage" --column "AppImage" ${list_app_image})
	launch_app="AppImage/${launch_app}.AppImage"
elif [[ "${selector}" = "Flatpak" ]]; then
	launch_app=$(zenity --list --title "Flatpak launcher" --text "Choose the App image you want to run" --column "Flatpak" ${list_flatpak})
	launch_app="Flatpak/${launch_app}"
else
	exit 0
fi

# Get status unprivileged_userns_clone
status_userns_clone=$(sysctl kernel.unprivileged_userns_clone | awk '{print $3}')

sysctl -w kernel.unprivileged_userns_clone=$(expr $status_userns_clone = 1)

su -c "/home/${default_user}/${launch_app}" "${default_user}"

status_userns_clone=$(sysctl kernel.unprivileged_userns_clone | awk '{print $3}')

sysctl -w kernel.unprivileged_userns_clone=$(expr $status_userns_clone = 0)

exit 0
