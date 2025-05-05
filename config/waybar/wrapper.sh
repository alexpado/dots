#!/bin/bash

# This wrapper allow to automatically restart waybar when a file in its config folder is modifier thus making a fake hot-reload.
CONFIG_DIR="$HOME/.config/waybar"

function _run {
    if [ -f "$CONFIG_DIR/.debug" ]; then
        GTK_DEBUG=interactive waybar &
    else
        waybar &
    fi
}

_run

while inotifywait -e close_write,moved_to,create -r "$CONFIG_DIR"; do
    pkill waybar
    sleep 0.3
    _run
done
