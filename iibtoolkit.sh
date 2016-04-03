#!/bin/bash

mkdir -p .iibtoolkit-docker
docker run -ti --rm \
           -e DISPLAY=$DISPLAY \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v `pwd`/.iibtoolkit-docker:/home/dev \
           local/iibtoolkit:1 \
	   $1 $2 $3 $4 $5 $6 $7 $8 $9
