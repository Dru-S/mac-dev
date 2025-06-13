#!/bin/zsh

SHOPIFY_SESSION="$1"
#
SHOPIFY_PANES_CMD_PRE="nvm use --silent"
#
SHOPIFY_PANE_DEV_ID="dev"
SHOPIFY_PANE_DEV_CMD="npm run dev"
#
SHOPIFY_PANE_FRONTEND_ID="frontend"
SHOPIFY_PANE_FRONTEND_CMD="npm start"
#
SHOPIFY_PANE_UTILS_ID="utils"
SHOPIFY_PANE_UTILS_CMD="echo \"$EOL\" >> theme/assets/sn-common.css"

# Resize terminal
SHOPIFY_TERMINAL_LINES="$(tput lines)"
SHOPIFY_TERMINAL_COLS="$(tput cols)"
printf "\e[8;$(echo $SHOPIFY_TERMINAL_LINES);$(echo $SHOPIFY_TERMINAL_COLS)t"

# Start `tmux`
# tmux start-server

# Create session
tmux new-session -d -s $SHOPIFY_SESSION -y $(tput lines) -x $(tput cols)
tmux set -g pane-border-status top

# Create various panes

# Create "Dev" pane
tmux select-pane -T $SHOPIFY_SESSION:0.$SHOPIFY_PANE_DEV_ID

# Create "Frontend" pane
# Starts with index 1, since it's the second to be created, but becomes the
# index 2 after the creation of the "utils" one
tmux select-pane -t $SHOPIFY_SESSION:0.$SHOPIFY_PANE_DEV_ID
tmux split-window -h
tmux select-pane -T $SHOPIFY_SESSION:0.$SHOPIFY_PANE_FRONTEND_ID

# Create "Utils" pane
tmux select-pane -t $SHOPIFY_SESSION:0.$SHOPIFY_PANE_DEV_ID
tmux split-pane -v
tmux select-pane -T $SHOPIFY_SESSION:0.$SHOPIFY_PANE_UTILS_ID

# Send Keys (basically, commands)
tmux send-keys -t $SHOPIFY_SESSION:0.$SHOPIFY_PANE_DEV_ID "$SHOPIFY_PANES_CMD_PRE" Enter
tmux send-keys -t $SHOPIFY_SESSION:0.$SHOPIFY_PANE_FRONTEND_ID "$SHOPIFY_PANES_CMD_PRE" Enter
tmux send-keys -t $SHOPIFY_SESSION:0.$SHOPIFY_PANE_DEV_ID "$SHOPIFY_PANE_DEV_CMD"
tmux send-keys -t $SHOPIFY_SESSION:0.$SHOPIFY_PANE_FRONTEND_ID "$SHOPIFY_PANE_FRONTEND_CMD"
tmux send-keys -t $SHOPIFY_SESSION:0.$SHOPIFY_PANE_UTILS_ID "$SHOPIFY_PANE_UTILS_CMD"

# Select the "Frontend" pane, which is likely to be the one you write or send commands to.
tmux select-pane -t $SHOPIFY_SESSION:0.$SHOPIFY_PANE_FRONTEND_ID

# Resize
tmux resize-pane -t $SHOPIFY_SESSION:0.$SHOPIFY_PANE_UTILS_ID -y 5

#

tmux attach-session -t $SHOPIFY_SESSION

#

nvm use