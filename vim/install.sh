#!/bin/bash -e

# Create directory for .viminfo and backup files
mkdir -p $HOME/.cache/vim/backup

# Build ctags for tagbar plugin
if ! type ctags > /dev/null; then
  BUILD_DIR="/tmp/ctags"
  mkdir -p $BUILD_DIR
  git clone https://github.com/universal-ctags/ctags.git "$BUILD_DIR"
  cd "$BUILD_DIR"
  ./autogen.sh
  ./configure
  make
  make install
fi