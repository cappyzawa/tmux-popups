#!/usr/bin/env bash

# tmux-popups: Simple popup command launcher
#
# Usage in .tmux.conf:
#   set -g @popup_g 'lazygit'
#   set -g @popup_G 'gh dash'
#
# Options:
#   @popup_width  - Popup width (default: 80%)
#   @popup_height - Popup height (default: 80%)
#   @popup_shell  - Shell to use (default: zsh -ic)

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
    local width height shell

    width=$(get_tmux_option "@popup_width" "80%")
    height=$(get_tmux_option "@popup_height" "80%")
    shell=$(get_tmux_option "@popup_shell" "zsh -ic")

    # Read all @popup_X options and create keybindings
    while IFS= read -r line; do
        # Skip @popup_width, @popup_height, @popup_shell
        case "$line" in
            @popup_width*|@popup_height*|@popup_shell*) continue ;;
        esac

        # Extract key and command from @popup_X "command"
        if [[ "$line" =~ ^@popup_(.+)[[:space:]][\"\']?([^\"\']+)[\"\']?$ ]]; then
            key="${BASH_REMATCH[1]}"
            cmd="${BASH_REMATCH[2]}"

            tmux bind-key "$key" display-popup -E -T " $cmd " -w "$width" -h "$height" \
                -d "#{pane_current_path}" "$shell '$cmd'"
        fi
    done < <(tmux show-options -g 2>/dev/null | grep "^@popup_")
}

main
