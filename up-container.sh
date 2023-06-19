#!/bin/bash
docker-compose -f up-container/docker-compose.yml -p freenet up -d
docker container ls

if [ ! -z "$DISPLAY" ]; then
    # Display exists, run from graphical user interface
    read -p "Press [Enter] key to continue..."
fi