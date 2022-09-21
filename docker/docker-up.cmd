hostname > tmpFile
set /p HOSTNAME= < tmpFile
wsl hostname -I > tmpFile
set /p WSL_IP= < tmpFile
del tmpFile
docker compose up --force-recreate --build -d
