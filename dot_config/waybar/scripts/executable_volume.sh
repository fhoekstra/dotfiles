#!/usr/bin/env bash


CURRENT_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)

echo $1
echo $CURRENT_VOLUME

if [[ $# -lt 2 ]]
then
    DELTA=2
else
    DELTA="$2"
fi

echo "$DELTA"

if [[ "$1" == "inc" ]]; then
    echo 'increasing'
    let "SECOND_HIGHEST_VOLUME = 100 - $DELTA"
    if [[ $CURRENT_VOLUME -gt $SECOND_HIGHEST_VOLUME ]]
    then
        echo 'volume is close to max'
        pactl set-sink-volume @DEFAULT_SINK@ 100%  
    else 
        echo 'volume is not close to max'
        pactl set-sink-volume @DEFAULT_SINK@ +${DELTA}%
    fi
fi

if [[ "$1" == "dec" ]]
then
    echo "decreasing"
    pactl set-sink-volume @DEFAULT_SINK@ -${DELTA}%
fi

