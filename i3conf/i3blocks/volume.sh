#!/bin/bash


DefaultSink=$(pactl get-default-sink)
volume=$(pactl get-sink-volume $DefaultSink | awk '{print $5}')
muted=$(pactl get-sink-mute $DefaultSink | awk '{print $2}')

if [[ ( ${muted} = "oui" ) || ( ${muted} = "yes" ) || ( ${volume//%} = "0" )  ]]; then
  echo "🔇 $volume"
  echo "🔇 $volume"
elif [[ ${volume//%} -gt 66 ]]; then
  echo "🔊 $volume"
  echo "🔊 $volume"
elif [[ ${volume//%} -gt 33 ]]; then
  echo "🔉 $volume"
  echo "🔉 $volume"
else
  echo "🔈 $volume"
  echo "🔈 $volume"
fi

echo "#0000ff"

exit 0
