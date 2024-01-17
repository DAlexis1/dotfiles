#!/bin/bash

config_file=$(find / | grep "AppImage/.config" | head -n 1)
default_user=$(cat "${config_file}" | grep "default_user" | sed -e "s/default_user=//g")

list_app_image=$(ls "/home/${default_user}/AppImage" | sed -e "s/.AppImage//g" | sed -e "s/\n/ /g")
launch_app=$(zenity --list --title "appimage launcher" --text "Choose an AppImage" --column "AppImage" ${list_app_image})

# Get status unprivileged_userns_clone
status_userns_clone=$(sysctl kernel.unprivileged_userns_clone | awk '{print $3}')

sysctl -w kernel.unprivileged_userns_clone=$(expr $status_userns_clone + 1)

su -c "/home/${default_user}/AppImage/${launch_app}.AppImage" "${default_user}"

status_userns_clone=$(sysctl kernel.unprivileged_userns_clone | awk '{print $3}')

sysctl -w kernel.unprivileged_userns_clone=$(expr $status_userns_clone - 1)

exit 0
