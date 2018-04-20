export NODE_REPL_HISTORY="$HOME/.cache/.node_repl_history"

export NVM_DIR="$HOME/.nvm"

function init_nvm {
  unset -f nvm node npm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

function nvm {
  init_nvm
  nvm "$@"
}

function node {
  init_nvm
  node "$@"
}

function npm {
  init_nvm
  npm "$@"
}
