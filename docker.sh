#!/bin/bash
set -ex

echo "Installing docker ..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install -y docker-ce
sudo usermod -aG docker ${USER}
echo 'hulmi ALL=(ALL) NOPASSWD: /usr/bin/dockerd' | sudo EDITOR='tee -a' visudo

echo "Installing docker-compose ..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Configuring profile ..."
cat <<EOT >> ~/.profile

# Start Docker daemon automatically when logging in if not running.
RUNNING=\`ps aux | grep dockerd | grep -v grep\`
if [ -z "\$RUNNING" ]; then
    sudo dockerd > /dev/null 2>&1 &
    disown
fi
EOT
