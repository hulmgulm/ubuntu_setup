#!/bin/bash

echo "Installing NodeJs ..."
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

# You may also need development tools to build native addons:
#sudo apt-get install gcc g++ make
