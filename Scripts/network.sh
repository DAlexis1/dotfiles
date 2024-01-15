#!/bin/bash

#Get the name of the interface used (it will take the first one from /proc/net/wireless)
Interface=$(cat /proc/net/wireless | awk '{print $1}' | tail -n +3 | head -n 1)
Interface=${Interface%:}

#Get the name of the network
Network=$(nmcli | less | grep "${Interface}:" | head -n 1 | cut -d " " -f 4-)

NetworkState=$(cat /proc/net/wireless | grep "${Interface}" | awk '{print $3}')
NetworkState=${NetworkState%.}

case $Interface in
"")
	Network="No Connection 󰖪 "
	NetworkState=""
	;;
*)
	if [[ ${NetworkState} -gt 75 ]]; then
		NetworkState=" ▂▄▆█"
	elif [[ ${NetworkState} -gt 50 ]]; then
		NetworkState=" ▂▄▆_"
	elif [[ ${NetworkState} -gt 25 ]]; then
		NetworkState=" ▂▄__"
	else
		NetworkState=" ▂___"
	fi
	;;
esac

case $Network in 
  "a "*)
    Network="Connecting 󰑓 "
    NetworkState=""
    ;;
esac

if [[ $(nmcli | grep " VPN ") ]]; then
	echo "VPN:Yes ${Network} ${NetworkState}"
else
	echo "VPN:No | ${Network}${NetworkState}"
fi

exit 0
