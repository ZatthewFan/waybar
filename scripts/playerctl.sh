#!/bin/bash

# Function to get and format the current player status
get_player_status() {
    status=$(playerctl status 2>/dev/null)

    if [[ "$status" == "Playing" ]]; then
        artist=$(playerctl metadata artist 2>/dev/null)
        title=$(playerctl metadata title 2>/dev/null)
        echo "$artist - $title"
    elif [[ "$status" == "Paused" ]]; then
        echo "⏸ Paused"
    else
        echo ""
    fi
}

# Output initial status
get_player_status

# Listen for playerctl events and update when media changes
playerctl --follow metadata --format '{{status}}' 2>/dev/null | while read -r line; do
    get_player_status
done
