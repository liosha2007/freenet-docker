#!/bin/sh
docker build --file freenet-build-image/Dockerfile --no-cache --tag freenet:x86-alpine-openjdk12-01497-oni ./ --build-arg freenet_build=build01497
read -p "Press [Enter] key to continue..."