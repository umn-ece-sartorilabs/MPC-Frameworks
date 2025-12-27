#!/usr/bin/env bash

set -e

IMAGE_NAME="mpc-frameworks"
DOCKERFILE="Dockerfile"
PARENT_DIR="$(pwd)"

docker build \
    --build-arg HOST_UID=$(id -u) \
    --build-arg HOST_GID=$(id -g) \
    -t "$IMAGE_NAME" \
    -f "$DOCKERFILE" .

docker run -it --rm \
    -v "$PARENT_DIR":/workspace \
    "$IMAGE_NAME" /bin/bash