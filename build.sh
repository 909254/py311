#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
IMAGE_NAME=${1:-biaoshen-py311:latest}

cd "$PROJECT_ROOT"
echo "Building $IMAGE_NAME ..."
docker build --file docker/py311/Dockerfile --tag "$IMAGE_NAME" .
echo "Built $IMAGE_NAME successfully."
