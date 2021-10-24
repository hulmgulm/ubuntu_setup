#!/bin/bash
set -ex

echo "Installing NodeJs and build tools ..."
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

echo "Installing build tools for native modules ..."
sudo apt install -y gcc g++ make

echo "Installing global node_modules ..."
sudo npm install grunt eslint -g
