#!/bin/bash

if [ $# -ne 1 ] ; then
  echo usage : 1 parameter is required
  exit 1
fi

DOCKER_CMD=docker
DIRECTORY=`basename $1`

# ${DOCKER_CMD} run -ti --net=host --privileged -e DISPLAY=${DISPLAY} --rm --name ${DIRECTORY} ${DIRECTORY}

SCRIPT_DIR=$(cd ${DIRECTORY}; pwd)
${DOCKER_CMD} run -ti -p 8888:8888 -v ${SCRIPT_DIR}:/home/practice_scala/src --rm --name scala_practice_image scala_practice_image
