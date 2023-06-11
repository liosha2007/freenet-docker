#!/bin/sh

# remove all containers which has freenet_conf or freenet_data in it's name
docker volume ls | grep -E "freenet_conf|freenet_data" | awk '{print $2}' | xargs docker volume rm

read -p "Press [Enter] key to continue..."
