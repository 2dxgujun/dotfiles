#!/bin/bash

set -e

DOTFILES_PATH=$(pwd -P)

echo "Initing submodules" | git submodule update --init

if [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  if [ "$(expr substr $(uname -m) 1 3)" = "x86" ]; then
    # Check for Homebrew
    if [ ! $(which brew) ]; then
      echo "Installing Homebrew for you."
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    fi

    if [ -d "/home/linuxbrew/.linuxbrew" ]; then
      BREW_HOME="/home/linuxbrew/.linuxbrew"
    else
      BREW_HOME="$HOME/.linuxbrew"
    fi

    export PATH="$BREW_HOME/bin:$PATH"
    
    # Run Homebrew through the Brewfile
    echo "> brew bundle" | brew bundle -v
  else
    # Use apt instead of brew on arm platform
    echo "apt install"
    sudo apt update
    sudo apt install $(awk -F\' '/^brew/{ print $2 }' Brewfile)
  fi
else 
  echo "Skip install bottles, only supported for Linux"
fi

OVERWRITE_ALL=false
BACKUP_ALL=false
SKIP_ALL=false

prompt () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file () {
  local src="$1" dst="$2"

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

    if [ "$OVERWRITE_ALL" == "false" ] && [ "$BACKUP_ALL" == "false" ] && [ "$SKIP_ALL" == "false" ]; then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]; then

        skip=true;

      else

        prompt "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            OVERWRITE_ALL=true;;
          b )
            backup=true;;
          B )
            BACKUP_ALL=true;;
          s )
            skip=true;;
          S )
            SKIP_ALL=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$OVERWRITE_ALL}
    backup=${backup:-$BACKUP_ALL}
    skip=${skip:-$SKIP_ALL}

    if [ "$overwrite" == "true" ]; then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]; then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]; then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]; then # "false" or empty
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

# Create symbolic link
for src in $(find -H "$DOTFILES_PATH" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
do
  dst="$HOME/.$(basename "${src%.*}")"
  link_file "$src" "$dst"
done

# Find the install.sh and run them iteratively
find . -maxdepth 2 -name 'install.sh' ! -path './install.sh' |
  while read script ; do
    sh -c "${script}"
  done

echo 'Done'