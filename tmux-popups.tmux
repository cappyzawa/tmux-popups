#!/usr/bin/env bash

# tmux-popups: Simple popup command launcher
#
# Usage in .tmux.conf:
#   set -g @popup_g 'lazygit'
#   set -g @popup_l 'gh cd -p 1'
#
# Then use: C-t C-p g → lazygit, C-t C-p l → gh cd
#
# Options:
#   @popup_prefix - Prefix key for popup table (default: C-p)
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
    local prefix width height shell table_opt

    prefix=$(get_tmux_option "@popup_prefix" "C-p")
    width=$(get_tmux_option "@popup_width" "80%")
    height=$(get_tmux_option "@popup_height" "80%")
    shell=$(get_tmux_option "@popup_shell" "zsh -ic")

    # If prefix is set, use key table
    if [ -n "$prefix" ]; then
        tmux bind-key "$prefix" switch-client -T popup
        table_opt="-T popup"
    else
        table_opt=""
    fi

    # Read all @popup_X options and create keybindings
    while IFS= read -r line; do
        # Skip reserved options
        case "$line" in
            @popup_width*|@popup_height*|@popup_shell*|@popup_prefix*) continue ;;
        esac

        # Extract key and command from @popup_X "command"
        if [[ "$line" =~ ^@popup_([^[:space:]]+)[[:space:]]+[\"\']?([^\"\']+)[\"\']?$ ]]; then
            key="${BASH_REMATCH[1]}"
            cmd="${BASH_REMATCH[2]}"

            # shellcheck disable=SC2086
            tmux bind-key $table_opt "$key" display-popup -E -T " $cmd " -w "$width" -h "$height" \
                -d "#{pane_current_path}" "$shell '$cmd'"
        fi
    done < <(tmux show-options -g 2>/dev/null | grep "^@popup_")
}

main
