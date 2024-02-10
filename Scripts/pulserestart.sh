#!/bin/bash


volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
pkill pulseaudio 
pkill pipewire
pulseaudio --start || pactl set-sink-volume @DEFAULT_SINK@ "${volume}%"
exit 0
