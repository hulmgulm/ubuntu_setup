#!/bin/bash
set -ex

echo "Updating installation ..."
sudo apt update
sudo apt upgrade -y

echo "Installing zsh ..."
sudo apt install -y zsh git wget binutils

if [ ! -z "$HTTP_PROXY" ]; then
  WGET_PROXY="-e use_proxy=yes -e https_proxy=$HTTP_PROXY"
fi
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh $WGET_PROXY -O -)"
