hostname > tmpFile
set /p HOSTNAME= < tmpFile
del tmpFile
docker-compose up --force-recreate --build -d
