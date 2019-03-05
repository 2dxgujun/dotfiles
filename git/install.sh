#!/bin/bash -e

LOCAL_GITCONF="$HOME/.gitconfig.local"

if [ ! -e "$LOCAL_GITCONF" ]; then
  touch $LOCAL_GITCONF
fi
