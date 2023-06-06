#!/bin/bash

sudo docker-compose down --remove-orphans
sudo docker network rm $(sudo docker network ls -q)
sudo docker rm $(sudo docker ps -q -f status=exited)
