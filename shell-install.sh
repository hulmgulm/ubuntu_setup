#!/bin/bash
set -ex

# detect if proxy config is needed
ping web-proxy.eu.softwaregrp.net -c 1 > /dev/null
if [ "$?" = "0" ]; then
  export HTTP_PROXY=http://web-proxy.eu.softwaregrp.net:8080
  export HTTPS_PROXY=$HTTP_PROXY
  WGET_PROXY="-e use_proxy=yes -e https_proxy=$HTTP_PROXY"
fi

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
