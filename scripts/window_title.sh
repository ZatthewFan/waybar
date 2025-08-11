#!/bin/bash

# Get the window title
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
