# This loads nvm
export NVM_DIR="$HOME/.nvm"
export NVM_HOME="$BREW_HOME/opt/nvm"

function nvm {
  if [ -s "$NVM_HOME/nvm.sh" ]; then 
    . "$NVM_HOME/nvm.sh"
  fi
}