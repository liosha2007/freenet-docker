#!/bin/bash
docker build --file freenet-build-image/Dockerfile --no-cache --tag freenet:arm32v7-ubuntu-18.04-01497-ofi ./ --build-arg freenet_build=build01497

if [ ! -z "$DISPLAY" ]; then
    # Display exists, run from graphical user interface
    read -p "Press [Enter] key to continue..."
fi