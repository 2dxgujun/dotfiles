#!/bin/bash -e

# Make directory for zsh temp files
mkdir -p $HOME/.cache/zsh

# Make directory for .z file
mkdir -p $HOME/.cache/z

DOTFILES="$( cd "$(dirname "$1")" ; pwd -P )"

MY_ZSHRC="$HOME/.myzshrc"

if [ ! -e "$MY_ZSHRC" ]; then
  echo "export DOTFILES=\"$DOTFILES\"" >> $MY_ZSHRC
fi

if [ -n "$LINUX" ]; then
  sudo usermod -s $(which zsh) $USER
fi
