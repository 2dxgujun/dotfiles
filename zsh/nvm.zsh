# This loads nvm
export NVM_DIR="$HOME/.nvm"
function nvm {
  if [ -s "$NVM_DIR/nvm.sh" ]; then 
    . "$NVM_DIR/nvm.sh"
    nvm use system
    nvm $@
  fi
}