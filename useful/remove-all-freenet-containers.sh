#!/bin/sh

# remove all container which were created using freenet image
docker rm $(docker ps -a -q --filter "ancestor=freenet:x86-alpine-openjdk12-01497-oni")
