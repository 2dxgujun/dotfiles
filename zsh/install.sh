#!/bin/bash -e

# Make directory for zsh temp files
mkdir -p $HOME/.cache/zsh

# Make directory for .z file
mkdir -p $HOME/.cache/z

DOTFILES="$( cd "$(dirname "$1")" ; pwd -P )"

LOCAL_ZSHRC="$HOME/.zshrc.local"

if [ ! -e "$LOCAL_ZSHRC" ]; then
  echo "export DOTFILES=\"$DOTFILES\"" >> $LOCAL_ZSHRC
fi

if [ "$OS" == "Linux" ]; then
  sudo usermod -s $(which zsh) $USER
fi
