#!/bin/bash -e

# Install tmux plugin
$DOTFILES/tmux/plugins/tpm/bin/install_plugins

MY_TMUXCONF="$HOME/.mytmux.conf"

if [ ! -e "$MY_TMUXCONF" ]; then
  touch $MY_TMUXCONF
fi
