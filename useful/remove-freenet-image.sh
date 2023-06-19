#!/bin/bash

# remove freenet image
docker image rm freenet:arm32v7-ubuntu-18.04-01497-ofi

if [ ! -z "$DISPLAY" ]; then
    # Display exists, run from graphical user interface
    read -p "Press [Enter] key to continue..."
fi
