#!/bin/sh

set -e

DOTFILES=$(pwd -P)

if [ -w /home/linuxbrew ]; then
  BREW_HOME="/home/linuxbrew/.linuxbrew"
else
  BREW_HOME="~/.linuxbrew"
fi

PATH="$BREW_HOME/bin:$PATH"
PATH="$BREW_HOME/Homebrew/Library/Homebrew/vendor/portable-ruby/2.3.3/bin:$PATH"

# Check for Homebrew
if [ ! $(which brew) ]; then
  echo "  Installing Homebrew for you."
  if [ "$(uname)" = "Darwin" ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
  	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  fi
fi

# Run Homebrew through the Brewfile
echo "> brew bundle" && brew bundle

OVERWRITE_ALL=false
BACKUP_ALL=false
SKIP_ALL=false

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$OVERWRITE_ALL" == "false" ] && [ "$BACKUP_ALL" == "false" ] && [ "$SKIP_ALL" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
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

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

# Install dotfiles
for src in $(find -H "$DOTFILES" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
do
  dst="$HOME/.$(basename "${src%.*}")"
  link_file "$src" "$dst"
done

# Find the installers and run them iteratively
find . -name install.sh | while read installer ; do sh -c "${installer}" ; done

echo ''
echo '  Done'