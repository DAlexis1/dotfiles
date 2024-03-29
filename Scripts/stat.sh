#!/bin/bash

# Red colour
RED="^c#FF0000^"
# Green colour
GREEN="^c#00FF00^"
# No Colour
NC="^d^"
# Delimiter
DELIM=" "

LOW_BAT=false

function battery() {
	bat=$(</sys/class/power_supply/BAT0/capacity)

	if (($bat < 25)); then
		if (($bat <= 10)) && [ "$LOW_BAT" = false ]; then
			LOW_BAT=true
			echo -e "\uf244 $bat%"
			notify-send -u critical "Low Battery" "Battery is $bat% plug into charger"
		else
			LOW_BAT=false
			echo -e "\uf243 $bat%"
		fi
	elif (($bat < 50)); then
		LOW_BAT=false
		echo -e "\uf242 $bat%"
	elif (($bat < 75)); then
		LOW_BAT=false
		echo -e "\uf241 $bat%"
	else
		LOW_BAT=false
		echo -e "\uf240 $bat%"
	fi
}

function volume() {
	vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed -e "s/%//g")
	mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

	if [ "$mute" == "oui" ]; then
		echo -e "\uf6a9"
	elif (($vol < 25)); then
		echo -e "\uf026 $vol%"
	elif (($vol < 50)); then
		echo -e "\uf027 $vol%"
	else
		echo -e "\uf028 $vol%"
	fi
}

function wifi() {
	ethernetstatus=$(cat /sys/class/net/enp2s0f0/operstate)
	if [[ "$ethernetstatus" == "up" ]]; then
		echo "$ethernetstatus pluged in $ip"
	else
		wifistatus=$(cat /sys/class/net/wlp3s0/operstate)
		if [[ "$wifistatus" == "up" ]]; then
			echo -e "\uf1eb"
		fi
	fi
	ip=$(wget http://ipecho.net/plain -O - -q)
	echo "$ip"
}

function weather() {
	d=$(head -n 1 wttr.txt)
	if [ "$d" != $(date "+%d/%m/%Y") ]; then
		date "+%d/%m/%Y" >wttr.txt
		curl wttr.in/Melbourne?format=%t%w >>wttr.txt
	fi
	echo "$(head -n 2 wttr.txt | grep C | sed -e 's/C/C /g')"
}

function bluetooth() {
	echo -e "\uf294"
}

function status() {

	echo $DELIM

	wifi

	echo $DELIM

	battery

	echo $DELIM

	volume

	echo $DELIM

	date "+%d/%m/%Y %H:%M"

	echo -e "\uf17c"
}

while :; do
	xsetroot -name "$(status | tr '\n' ' ')"

	# Sleep for 1 minute before updating the status bar
	sleep 1m
done
#
#
# while :; do
#     xsetroot -name "$(i3blocks -c /home/sandor/.config/i3/i3blocks.conf)"
#     sleep 10
# done
