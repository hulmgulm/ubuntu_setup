#!/bin/bash
# sh -c "$(wget https://raw.githubusercontent.com/hulmgulm/ubuntu_setup/refs/heads/main/shell-install.sh -O -)"
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

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
