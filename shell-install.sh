#!/bin/bash
set -ex

# checking which installer to use
INSTALLER=apt
if ! command -v apt &> /dev/null
then
  # use yum on centos
  INSTALLER=yum
fi

echo "Updating installation ..."
sudo $INSTALLER update
sudo $INSTALLER upgrade -y

echo "Installing zsh ..."
sudo $INSTALLER install -y zsh git wget binutils jq

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh $WGET_PROXY -O -)"
