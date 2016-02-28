#!/bin/bash

###################
# Run this script to build a Docker image from the git tree.
###################

#### Configuration ####
BUILDER_IMAGE_NAME="hervenicol/mldonkey-builder"
IMAGE_NAME="hervenicol/mldonkey"
#### End configuration ####

docker build --force-rm=true -t "$BUILDER_IMAGE_NAME" -f builder.Dockerfile .

docker run --rm -ti -v $PWD/distrib:/distrib "$BUILDER_IMAGE_NAME"

docker build --force-rm=true -t "$IMAGE_NAME" -f Dockerfile .


