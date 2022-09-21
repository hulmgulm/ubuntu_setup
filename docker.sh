#!/bin/bash
set -ex

# checking which installer to use
if ! command -v apt &> /dev/null
then
  # use yum on centos
  INSTALLER=yum
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
else
  INSTALLER=apt
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
fi

echo "Installing docker ..."
sudo apt install --no-install-recommends  -y apt-transport-https ca-certificates curl gnupg2

if [ -f /etc/os-release ]; then
  # On Debian or Ubuntu temporarily set some OS-specific variables
  source /etc/os-release
  # Make sure that apt will trust the repo
  curl -fsSL https://download.docker.com/linux/${ID}/gpg | sudo apt-key add -
  echo "deb [arch=amd64] https://download.docker.com/linux/${ID} ${VERSION_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/docker.list
  sudo apt update
fi

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker ${USER}
echo '${USER} ALL=(ALL) NOPASSWD: /usr/bin/dockerd' | sudo EDITOR='tee -a' visudo

echo "Configuring profile ..."
cat <<EOT >> ~/.profile

# Start Docker daemon automatically when logging in if not running.
RUNNING=\`ps aux | grep dockerd | grep -v grep\`
if [ -z "\$RUNNING" ]; then
    sudo dockerd > /dev/null 2>&1 &
    disown
fi
EOT
