#!/bin/bash

Interface=$(nmcli | less | head -n 1 | awk '{print $1}')
Interface=${Interface%:}
Network=$(nmcli | less | head -n 1 | awk '{print $4}')

NetworkState=$(cat /proc/net/wireless | grep ${Interface} | awk '{print $3}')
NetworkState=${NetworkState%.}

if [[ ${NetworkState} -gt 75 ]]; then
  NetworkState="▂▄▆█"
elif [[ ${NetworkState} -gt 50 ]]; then
  NetworkState="▂▄▆_"
elif [[ ${NetworkState} -gt 25 ]]; then
  NetworkState="▂▄__"
else
  NetworkState="▂___"
fi

echo "${Network} ${NetworkState}"

exit 0
