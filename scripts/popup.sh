#!/usr/bin/env bash

# Get current pane dimensions and position
width=$(tmux display -p "#{pane_width}")
x=$(tmux display -p "#{pane_left}")
y=$(tmux display -p "#{pane_top}")
dir=$(tmux display -p "#{pane_current_path}")
shell=$(tmux show-option -gv default-shell)

# Open popup aligned to current pane
shell_name=$(basename "$shell")
tmux display-popup -E -T " $shell_name " -w "$width" -h 40% -x "$x" -y "$y" -d "$dir" "$shell --login"
