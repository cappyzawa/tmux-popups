#!/usr/bin/env bash

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value
    option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

# Get current pane dimensions and position
pane_width=$(tmux display -p "#{pane_width}")
pane_height=$(tmux display -p "#{pane_height}")
x=$(tmux display -p "#{pane_left}")
y=$(tmux display -p "#{pane_top}")
dir=$(tmux display -p "#{pane_current_path}")
shell=$(tmux show-option -gv default-shell)

# Get size options (support "pane" as special value)
width=$(get_tmux_option "@popup_width" "pane")
height=$(get_tmux_option "@popup_height" "40%")

# Resolve "pane" to actual pane dimensions
[ "$width" = "pane" ] && width="$pane_width"
[ "$height" = "pane" ] && height="$pane_height"

# Open popup aligned to current pane
shell_name=$(basename "$shell")
tmux display-popup -E -T " $shell_name " -w "$width" -h "$height" -x "$x" -y "$y" -d "$dir" "$shell --login"
