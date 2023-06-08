#!/usr/bin/env bash
#set video as wallpaper using xwinwrap and mpv - change path to your video!!

xwinwrap -ni -fs -s -st -sp -b -nf -- mpv --osd-fractions=yes --profile=wallpaper -wid %WID /home/pp311/.config/video-wallpapers/wallpapers/12.mp4
