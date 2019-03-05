#!/bin/bash -e

# Install tmux plugin
$DOTFILES/tmux/plugins/tpm/bin/install_plugins

LOCAL_TMUXCONF="$HOME/.tmux.conf.local"

if [ ! -e "$LOCAL_TMUXCONF" ]; then
  touch $LOCAL_TMUXCONF
fi
