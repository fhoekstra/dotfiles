#!/usr/bin/env bash

# Adjust this to your actual path from TODO
SYSFS_PATH=/devices/platform/i8042/serio0/input/input3

DEV_PATH="/sys/${SYSFS_PATH}/inhibited"

if [ ! -e "$DEV_PATH" ]; then
    echo "Keyboard inhibit file not found: $DEV_PATH" >&2
    exit 1
fi

case "$1" in
    disable)
        echo 1 | sudo tee "$DEV_PATH" > /dev/null
        ;;
    enable)
        echo 0 | sudo tee "$DEV_PATH" > /dev/null
        ;;
    toggle)
        cur=$(cat "$DEV_PATH")
        new="1"
        if [ "$cur" = "1" ]; then $new="0"; fi
        echo $new | sudo tee "$DEV_PATH" > /dev/null
        ;;
    *)
        echo "Usage: $0 {enable|disable|toggle}" >&2
        exit 1
        ;;
esac
