# shell.sh
Installs everything needed inside WSL Ubuntu 20.04:
* zsh
* oh-my-zsh + theme
* adjustments for MobaXterm

# node.sh
Installs NodeJs 14.x

# docker.sh
Installs docker and docker-compose. Docker dockerd will get started automatically when WLS is opened

# docker-compose.yml
Dev setup containers
* redis
* redis-commander
* postgres
* pgadmin
* portainer
* swagger-editor
* nginx

Run the following command to force pull of images:

`docker-compose up --force-recreate --build -d`

# Windows Setup
* allow `C:\Windows\System32\wsl.exe` through Windows firewall
* create `C:\Users\me\.wslconfig` with content:

```
[wsl2]
localhostForwarding=true
````
