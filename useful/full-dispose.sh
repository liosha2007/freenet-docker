#!/bin/bash


chmod +x ./stop-all-freenet-containers.sh ./remove-all-freenet-containers.sh ./remove-all-freenet-volumes.sh ./remove-freenet-image.sh

./stop-all-freenet-containers.sh \
  && ./remove-all-freenet-containers.sh \
  && ./remove-all-freenet-volumes.sh \
  && ./remove-freenet-image.sh
