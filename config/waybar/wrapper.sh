#!/bin/bash

#
# This wrapper allow to automatically restart waybar when a file in its config
# folder is modified (hot-reload), but also to load a specific configuration 
# file depending on the number of monitors attached.
#

CONFIGURATION_DIRECTORY="$HOME/.config/waybar"
WRAPPER_CONFIG="$CONFIGURATION_DIRECTORY/wrapper.json"
DEBUG=0

function reload() {
  if [ "$(cat $HOME/.config/waybar/wrapper.json | jq '.debug')" = "true" ]; then
    DEBUG=1 
  else 
    DEBUG=0
  fi
}

function run() {
  if [ "$DEBUG" -eq "1" ]; then
    GTK_DEBUG=interactive waybar --config "$CONFIGURATION_DIRECTORY/config.jsonc" &
  else
    waybar --config "$CONFIGURATION_DIRECTORY/config.jsonc" &
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
