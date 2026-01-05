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

shell=$(tmux show-option -gv default-shell)
dir=$(tmux display -p "#{pane_current_path}")

# Get size options
menu_width=$(get_tmux_option "@popup_menu_width" "60%")
menu_height=$(get_tmux_option "@popup_menu_height" "40%")
action_width=$(get_tmux_option "@popup_action_width" "80%")
action_height=$(get_tmux_option "@popup_action_height" "80%")

# Default actions: label:command format, comma separated
default_actions="shell:$shell --login,lazygit:lazygit"

actions=$(get_tmux_option "@popup_actions" "$default_actions")

# Temp file for selection
tmp_file=$(mktemp)
trap "rm -f $tmp_file" EXIT

# Write actions to temp file for fzf
echo "$actions" | tr ',' '\n' | cut -d: -f1 > "$tmp_file.labels"

# Run fzf in popup, write selection to tmp file
tmux display-popup -E -T " Select Action " -w "$menu_width" -h "$menu_height" -d "$dir" \
    "cat '$tmp_file.labels' | fzf --prompt='popup> ' --reverse > '$tmp_file'"

selected=$(cat "$tmp_file" 2>/dev/null)
rm -f "$tmp_file.labels"

if [ -n "$selected" ]; then
    cmd=$(echo "$actions" | tr ',' '\n' | grep "^${selected}:" | cut -d: -f2-)
    tmux display-popup -E -T " $selected " -w "$action_width" -h "$action_height" -d "$dir" "$shell -lic \"$cmd\""
fi
