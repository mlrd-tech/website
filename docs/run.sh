#!/bin/bash
set -eu
hugo serve \
  --minify \
  --disableKinds rss,taxonomy,term \
  --baseURL http://localhost:1313/docs/
