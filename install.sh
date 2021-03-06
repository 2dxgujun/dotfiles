#!/bin/bash -e

export DOTFILES=$(pwd -P)

git submodule update --init --recursive

if [[ "$(uname -s)" == "Darwin" ]]; then
  export OS="Darwin"
else
  export OS="Linux"
fi

if [[ "$OS" == "Darwin" ]]; then
  brew bundle
else 
  sudo apt update
  sudo apt install $(awk -F\' '//' Packages)
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
for src in $(find -H "$DOTFILES" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
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
