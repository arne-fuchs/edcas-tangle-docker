#!/bin/bash
sudo docker container stop $(sudo docker ps -q) && sudo docker compose down && sudo ./wipeDocker.sh && sudo ./cleanup.sh && git pull && sudo docker compose pull && sudo ./bootstrap.sh && sudo ./run.sh 4 && sudo docker ps -a
