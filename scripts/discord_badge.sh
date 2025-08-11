#!/bin/bash

# Get Discord window info from Hyprland (works with native Wayland Discord)
discord_info=$(hyprctl clients -j | jq -r '.[] | select(.class == "discord" or .class == "Discord" or .class == "vesktop" or .class == "webcord") | .title')

# Extract unread count from window title - adjust pattern based on your client
unread=$(echo "$discord_info" | grep -oP '\(\d+\)' | grep -oP '\d+' | head -1)

# Alternative patterns if the above doesn't work
if [[ -z "$unread" ]]; then
    unread=$(echo "$discord_info" | grep -oP '^\d+' | head -1)
fi

# Check if unread messages exist and set output accordingly
if [[ -n "$unread" && "$unread" -gt 0 ]]; then
    echo "󱅫 $unread"
else
    echo "󱏧"
fi
