#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
IMAGE_NAME=${1:-biaoshen-py311:latest}

mkdir -p "$PROJECT_ROOT/web_data"

set -- \
    --rm \
    --name biaoshen-py311 \
    --publish 8000:8000 \
    --env WEB_PORT=8000 \
    --env BID_REVIEW_PAGE_RENDERER=libreoffice \
    --env BID_REVIEW_LIBREOFFICE_PATH=/usr/bin/libreoffice \
    --mount "type=bind,source=$PROJECT_ROOT/web_data,target=/app/web_data"

if [ -f "$PROJECT_ROOT/.env" ]; then
    set -- "$@" --env-file "$PROJECT_ROOT/.env"
fi

exec docker run "$@" "$IMAGE_NAME"
