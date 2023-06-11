#!/bin/bash
# see man zscroll for documentation of the following parameters
zscroll -l 40 \
        --delay 0.2 \
        --scroll-padding "  " \
        --match-command "`dirname $0`/get_spotify_status.sh --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-interval 3 \
        --update-check true "`dirname $0`/get_spotify_status.sh" &

wait

