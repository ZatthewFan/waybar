#!/bin/bash

# Function to get and format the current window title
get_window_title() {
    title=$(hyprctl activewindow -j | jq -r '.title')
    
    # Reverse "Window Title - App Name" to "App Name - Window Title"
    if [[ "$title" == *" - "* ]]; then
        # Split on the last ' - '
        window_title="${title% - *}"
        app_name="${title##* - }"
        echo "$app_name - $window_title"
    else
        # If there's no delimiter, just show the raw title
        echo "$title"
    fi
}

# Output initial window title
get_window_title

# Listen for Hyprland events and update on window changes
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
    # Update on active window changes or window title changes
    if [[ $line == activewindow* ]] || [[ $line == windowtitle* ]]; then
        get_window_title
    fi
done
