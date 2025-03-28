#!/bin/bash
ignore_sessions="info amdgpu"
session=$(tmux display-message -p '#S')

[[ "ignore_sessions" = *"$session"* ]] && exit 0

# Get the number of panes in the current window
pane_count=$(tmux list-panes | wc -l)

if [ "$pane_count" -gt 1 ]; then
    # Show borders if more than one pane exists
    tmux set-window-option pane-border-status top
else
    tmux set-window-option pane-border-status off

fi
