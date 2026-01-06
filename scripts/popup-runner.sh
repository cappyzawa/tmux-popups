#!/bin/bash
# Run popup command by reading from tmux option

key="$1"
cmd=$(tmux show-option -gqv "@popup_$key")

# Remove surrounding quotes if present
cmd="${cmd#\"}"
cmd="${cmd%\"}"
cmd="${cmd#\'}"
cmd="${cmd%\'}"

if [ -n "$cmd" ]; then
    exec zsh -ic "$cmd"
fi
