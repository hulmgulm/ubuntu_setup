#!/bin/bash
set -ex

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

sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker ${USER}
echo '${USER} ALL=(ALL) NOPASSWD: /usr/bin/dockerd' | sudo EDITOR='tee -a' visudo

echo "Installing docker-compose ..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
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
