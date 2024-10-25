#!/usr/bin/env bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if X is running
is_x_running() {
    [ -n "$DISPLAY" ]
}

# Function to check if localhost:12345 is listening using socat
is_port_listening() {
    if command_exists "socat"; then
        socat -u OPEN:/dev/null TCP:localhost:12345,connect-timeout=1 >/dev/null 2>&1
    else
        return 1
    fi
}

# Function to get the appropriate copy command
get_copy_command() {
    if is_x_running && command_exists "xclip"; then
        echo "xclip -selection clipboard"
    elif ! is_x_running && is_port_listening && command_exists "socat"; then
        echo "socat - TCP:localhost:12345"
    else
        echo ""
    fi
}

# Get the copy command
copy_command=$(get_copy_command)

# Set up the binding for tmux 3.x if a copy command is available
if [ -n "$copy_command" ]; then
    tmux bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "$copy_command"
    echo "tmux-yank configured with command: $copy_command"
else
    echo "No suitable copy method found. tmux-yank-lite not configured."
fi
