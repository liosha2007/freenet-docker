#!/bin/sh

# remove all container which were created using freenet image
docker rm $(docker ps -a -q --filter "ancestor=freenet:arm32v7-ubuntu-18.04-01497-ofi")

read -p "Press [Enter] key to continue..."
