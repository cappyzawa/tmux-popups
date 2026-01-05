#!/usr/bin/env bash

# Get current pane dimensions and position
width=$(tmux display -p "#{pane_width}")
x=$(tmux display -p "#{pane_left}")
y=$(tmux display -p "#{pane_top}")
dir=$(tmux display -p "#{pane_current_path}")

# Open popup aligned to current pane
tmux display-popup -E -w "$width" -h 40% -x "$x" -y "$y" -d "$dir" "${SHELL:-/bin/sh}" -l
