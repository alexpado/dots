#!/bin/bash

CONFIG_DIR="$HOME/.config/waybar"

waybar &

while inotifywait -e close_write,moved_to,create -r "$CONFIG_DIR"; do
    pkill waybar
    sleep 0.3
    waybar &
done
