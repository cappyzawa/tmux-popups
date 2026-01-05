#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Default key bindings
default_popup_key="f"
default_popup_menu_key="F"

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
    local popup_menu_key

    popup_key=$(get_tmux_option "@popup_key" "$default_popup_key")
    popup_menu_key=$(get_tmux_option "@popup_menu_key" "$default_popup_menu_key")

    tmux bind-key "$popup_key" run-shell "$CURRENT_DIR/scripts/popup.sh"
    tmux bind-key "$popup_menu_key" run-shell "$CURRENT_DIR/scripts/menu.sh"
}

main
