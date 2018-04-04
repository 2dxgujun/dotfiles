#!/bin/bash

set -xe

NVM_DIR="$HOME/.nvm"

if [ ! -d "$NVM_DIR" ]; then
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
fi