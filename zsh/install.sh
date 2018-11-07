#!/bin/bash -e

# Make directory for zsh temp files
mkdir -p $HOME/.cache/zsh

# Make directory for .z file
mkdir -p $HOME/.cache/z

MY_ZSHRC="$HOME/.myzshrc"
DOTFILES_PATH="$( cd "$(dirname "$1")" ; pwd -P )"
if [ ! -e "$MY_ZSHRC" ]; then
  echo "export DOTFILES_PATH=\"$DOTFILES_PATH\"" >> $MY_ZSHRC
fi

