#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default key binding (can be overridden with @popup_key)
default_popup_key="f"

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

main() {
    local popup_key
    popup_key=$(get_tmux_option "@popup_key" "$default_popup_key")

    tmux bind-key "$popup_key" run-shell "$CURRENT_DIR/scripts/popup.sh"
}

main
