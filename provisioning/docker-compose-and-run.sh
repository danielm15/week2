#!/usr/bin/env bash

#docker kill $(docker ps -q)
#docker rm $(docker ps -aq)
#docker rmi -f $(docker images -q)
export GIT_COMMIT=$1
echo $GIT_COMMIT
docker-compose down
docker-compose up -d --build
