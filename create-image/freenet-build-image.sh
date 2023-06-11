#!/bin/sh
docker build --file freenet-build-image/Dockerfile --no-cache --tag freenet:arm32v7-ubuntu-18.04-01497-ofi ./ --build-arg freenet_build=build01497
read -p "Press [Enter] key to continue..."