# freenet-docker

Docker config to build Freenet image and run node in Docker container

## Building image

To build image go to `create-image` and run `freenet-build-image.sh` file.

## Running container

To run container go to `create-container` and run `freenet-up-container.sh` file.

## Opening page

To open Freenet page go to [http://localhost:8888](http://localhost:8888)

## Brunch naming

Brunch names has next structure:

1. Architecture (arm32v7/x86/...)
2. OS (Ubuntu/Alpine/...)
3. OS version (18.04/openjdk12/...)
4. Freenet version (01496/01497/...)
5. Freenet installation type (`oni` - online installation (Freenet installer will be downloading from releases section of [original repository](https://github.com/hyphanet/fred) during Docker Image building process), `ofi` - offline installation (Freenet installer will be copied from directory))

Examples:
* x86-alpine-openjdk12-01497-oni
* x86-alpine-openjdk12-01497-ofi
* arm32v7-ubuntu-18.04-01497-oni
* arm32v7-ubuntu-18.04-01497-ofi

## Tests

This branch (`arm32v7-ubuntu-18.04-01497-ofi`) is tested on NaniPi NEO 512M (Host OS is `Ubuntu 16.04.2 LTS 4.14.111`)