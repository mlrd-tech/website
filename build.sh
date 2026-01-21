#!/bin/bash

set -eu

rm -rf public/*

build() {
  hugo --minify --disableKinds rss,taxonomy,term --baseURL "$1"
}

cd docs && build "https://mlrd.tech/docs/" # build docs sub-site
cd ..   && build "https://mlrd.tech/"      # build mlrd.tech main site
