# This loads nvm
export NVM_DIR="$HOME/.nvm"

if [ ! -z ${BREW_HOME+x} ]; then
  export NVM_HOME="$BREW_HOME/opt/nvm"
else
  export NVM_HOME=$NVM_DIR
fi

function nvm {
  if [ -s "$NVM_HOME/nvm.sh" ]; then 
    . "$NVM_HOME/nvm.sh"
    nvm @$
  fi
}