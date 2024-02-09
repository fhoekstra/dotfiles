#!/bin/bash
 
entries="Active Screen Partial Output Window"
 
selected=$(printf '%s\n' $entries | tofi -c $HOME/.config/tofi/config.screenshot | awk '{print tolower($1)}')

destinations="Copy Save"
dest=$(printf '%s\n' $destinations | tofi -c $HOME/.config/tofi/config.screenshot | awk '{print tolower($1)}')

case $selected in
  active)
    /usr/share/sway/scripts/grimshot --notify $dest active;;
  screen)
    /usr/share/sway/scripts/grimshot --notify $dest screen;;
  output)
    /usr/share/sway/scripts/grimshot --notify $dest output;;
  partial)
    /usr/share/sway/scripts/grimshot --notify $dest area;;
  window)
    /usr/share/sway/scripts/grimshot --notify $dest window;;
esac
