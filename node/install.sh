#!/bin/bash

set -e

NVM_DIR = "$HOME/.nvm"

git clone https://github.com/creationx/nvm.git $NVM_DIR

pushd NVM_DIR && git checkout v0.33.8

popd