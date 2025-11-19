#!/bin/bash

CONFIG_DIR="$HOME/.config/hypr/setup"
HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"

current_config_full=$(head -n 1 "$HYPRLAND_CONFIG" | awk -F'/' '{print $NF}')
current_config_name=${current_config_full%.conf}

echo "Current Config: $current_config_name"

configs=$(ls -1 "$CONFIG_DIR"/*.conf | sed -e "s|$CONFIG_DIR/||" -e 's/\.conf$//')

selected_config_name=$(echo "$configs" | wofi --dmenu --prompt "Select Hyprland Profile:" "$current_config_name")

if [ -n "$selected_config_name" ]; then
    new_config_file="$selected_config_name.conf"
    sed -i "1s|.*|source = ~/.config/hypr/setup/$new_config_file|" "$HYPRLAND_CONFIG"
    sleep 1
    hyprctl reload
fi
