#!/usr/bin/env bash

set -e
branch_name=$(git rev-parse --abbrev-ref HEAD)
latest_version=$(echo $branch_name | grep -oP '\d+\.\d+\.\d+')
name=$(basename $PWD)
podman build \
  --sbom=true \
  --build-arg=RELEASE_VERSION=$latest_version \
  --label org.opencontainers.image.created=$(date --iso-8601=ns) \
  --label org.opencontainers.image.authors=gh:@ffimnsr \
  --label org.opencontainers.image.description="supabase/auth $latest_version" \
  --label org.opencontainers.image.revision=$(git rev-parse HEAD) \
  --label org.opencontainers.image.source=$(git remote get-url origin) \
  --label org.opencontainers.image.title=$name \
  --label org.opencontainers.image.url=https://github.com/ffimnsr/auth \
  --label org.opencontainers.image.version=$latest_version\
  -t docker.io/ifn4/$name:$latest_version .
