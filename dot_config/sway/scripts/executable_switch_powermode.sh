#!/usr/bin/env bash

set_output_slow ()
{
    if [ ! -z "$(swaymsg -t get_outputs | rg 'PHL 275E1')" ]; then
        if [ ! -z "$(swaymsg -t get_outputs | rg 'MD 20102')" ]; then
            kanshictl switch home_setup_low_refresh
        else
            kanshictl switch home_philips_low_refresh
        fi
    else
        kanshictl set int_only_60
    fi
}

set_output_fast ()
{
    if [ ! -z "$(swaymsg -t get_outputs | rg 'PHL 275E1')" ]; then
        if [ ! -z "$(swaymsg -t get_outputs | rg 'MD 20102')" ]; then
            kanshictl switch home_setup_high_refresh
        else
            kanshictl switch home_philips_high_refresh
        fi
    else
        kanshictl set int_only_gaming
    fi
}

GPU_MODE_BEFORE=$(supergfxctl -g)
if [ -z "$1" ]; then
	echo "No argument supplied"
elif [ $1 = "normal" ]; then
	set_output_slow
    sway-input input type:mouse accel_profile adaptive
	corectrl -m normal
	powerprofilesctl set balanced
	supergfxctl -m Integrated
    if [ "Integrated" != "${GPU_MODE_BEFORE}" ]; then
        notify-send "Relog required" "Due to switching the GPU mode, you need to log out and back in again." --icon=system-reboot
    fi
elif [ $1 = "battery" ]; then
	set_output_slow
    sway-input input type:mouse accel_profile adaptive
	powerprofilesctl set power-saver
	corectrl -m powersave
	brightnessctl set 0
	supergfxctl -m Integrated
    if [ "Integrated" != "${GPU_MODE_BEFORE}" ]; then
        notify-send "Relog required" "Due to switching the GPU mode, you need to log out and back in again." --icon=system-reboot
    fi
elif [ $1 = "gaming" ]; then
	set_output_fast
    sway-input input type:mouse accel_profile flat
	corectrl -m normal
	powerprofilesctl set performance
	brightnessctl set 100%
	supergfxctl -m Hybrid
    if [ "Hybrid" != "${GPU_MODE_BEFORE}" ]; then
        notify-send "Relog required" "Due to switching the GPU mode, you need to log out and back in again." --icon=system-reboot
    fi
fi

