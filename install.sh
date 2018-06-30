#!/bin/bash

set -e
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p ~/.config/nvim
ln -s $DIR/.vimrc ~/.config/nvim/init.vim
