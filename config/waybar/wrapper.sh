#!/bin/bash

#
# This wrapper allow to automatically restart waybar when a file in its config
# folder is modified (hot-reload), but also to load a specific configuration 
# file depending on the number of monitors attached.
#

CONFIGURATION_DIRECTORY="$HOME/.config/waybar"
WRAPPER_CONFIG="$CONFIGURATION_DIRECTORY/wrapper.json"

ACTIVE_CONFIGURATION=""
DEBUG=0

function reload() {
  ACTIVE_CONFIGURATION=$(hyprctl monitors -j | jq '.[] | .name' | wc -l | xargs -I % sh -c "cat $HOME/.config/waybar/wrapper.json | jq '.monitors' | jq --raw-output 'if has(\"%\") then .[\"%\"] else .[\"*\"] end'")
  
  # Here a small algorhythm to explain the goddamn subshell command...

  # monitorData = hyprctl monitors -j
  # monitorNames = jq '.[] | .name'
  # monitorCount = wc -l
  # wrapperMonitorConfig = wrapper.json | jq '.monitors'
  #
  # if wrapperMonitorConfig has monitorCount then
  #   return wrapperMonitorConfig.monitorCount
  # else
  #   return wrapperMonitorConfig.*
  # end

  if [ "$(cat $HOME/.config/waybar/wrapper.json | jq '.debug')" = "true" ]; then
    DEBUG=1 
  else 
    DEBUG=0
  fi
}

function run() {
  if [ "$DEBUG" -eq "1" ]; then
    GTK_DEBUG=interactive waybar --config "$CONFIGURATION_DIRECTORY/$ACTIVE_CONFIGURATION" &
  else
    waybar --config "$CONFIGURATION_DIRECTORY/$ACTIVE_CONFIGURATION" &
  fi
}

reload
run

while inotifywait -e close_write,moved_to,create -r "$CONFIGURATION_DIRECTORY"; do
  pkill waybar
  sleep 0.3
  reload
  run
done
