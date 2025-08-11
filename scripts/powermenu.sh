#!/bin/bash

options="Lock\nLogout\nReboot\nShutdown"

choice=$(echo -e "$options" | rofi -dmenu -p "Power Menu")

case "$choice" in
  Lock)
    # Uncomment the line below if you install hyprlock or swaylock
    # hyprlock

    # Fallback lock command
    loginctl lock-session || notify-send "Lock failed - no lock utility available"
    ;;
  Logout)
    hyprctl dispatch exit
    ;;
  Reboot)
    systemctl reboot
    ;;
  Shutdown)
    systemctl poweroff
    ;;
esac
