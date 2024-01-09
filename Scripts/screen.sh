#!/bin/bash

ConfigFiles=$(ls /home/"$USER"/Scripts/screen-config-files)
SetConfig=$(zenity --list --title ScreenConfig --text=$"Choose the config you wish to use\n$(xrandr | grep -cw connected) Screen connected" --column "Config" ${ConfigFiles})
exec /home/"$USER"/Scripts/screen-config-files/"${SetConfig}"

exit 0
