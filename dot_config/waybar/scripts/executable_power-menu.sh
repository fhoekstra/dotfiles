#!/bin/bash

entries="Lock Logout Reboot Shutdown"

selected=$(printf '%s\n' $entries | tofi -c $HOME/.config/tofi/config.power | awk '{print tolower($1)}')

case $selected in
  lock)
    swaylock;;
  logout)
    swaymsg exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
