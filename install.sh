#!/bin/bash

set -e
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TARGET_DIR="$HOME/.config/nvim"
FILES=("init.lua" "lua/plugins.lua" "lua/lsp.lua" "lua/treesitter.lua")

mkdir -p $TARGET_DIR/lua
for file in "${FILES[@]}"; do
  target=$TARGET_DIR/$file

  if [ ! -f $target ]; then
    # echo $DIR/$file $target
    ln -s $DIR/$file $target
  fi
done
