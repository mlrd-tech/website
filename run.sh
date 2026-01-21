#!/bin/bash

set -eu

rm -rf public/*

cd docs && hugo # build docs sub-site

if [[ "${1-""}" = "docs" ]]; then
  hugo server \
    --minify \
    --disableKinds rss,taxonomy,term \
    --baseURL http://localhost:1313
else
  cd ..
  hugo server \
    --minify \
    --disableKinds rss,taxonomy,term \
    --baseURL http://localhost:1313
fi
