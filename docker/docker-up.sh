#!/bin/bash
set -ex

export HOSTNAME=`hostname`
docker-compose up --force-recreate --build -d
