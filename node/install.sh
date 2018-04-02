#!/bin/bash

set -e

export NVM_DIR="$HOME/.nvm" && [ ! -d "$NVM_DIR" ] && (
  git clone https://github.com/creationix/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin`
) && \. "$NVM_DIR/nvm.sh"