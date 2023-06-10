#!/bin/sh
docker-compose -f freenet-up-container/docker-compose.yml -p freenet up -d
read -p "Press [Enter] key to continue..."