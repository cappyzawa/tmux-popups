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

# Default actions: label:command format, comma separated
default_actions='shell:$SHELL,lazygit:lazygit'

actions=$(get_tmux_option "@popup_actions" "$default_actions")
dir=$(tmux display -p "#{pane_current_path}")

# Parse actions and show menu with fzf
selected=$(echo "$actions" | tr ',' '\n' | cut -d: -f1 | fzf --prompt="popup> " --height=40% --reverse)

if [ -n "$selected" ]; then
    # Find the command for selected label
    cmd=$(echo "$actions" | tr ',' '\n' | grep "^${selected}:" | cut -d: -f2-)
    # Expand variables like $SHELL
    cmd=$(eval echo "$cmd")

    tmux display-popup -E -w 80% -h 80% -d "$dir" "$cmd"
fi
