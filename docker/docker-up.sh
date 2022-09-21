#!/bin/bash
set -ex

export HOSTNAME=`hostname`
export WSL_IP=`hostname -I | awk '{print $1}'`
docker ompose up --force-recreate --build -d
