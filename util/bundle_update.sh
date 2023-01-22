#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")/.."

bundle update "$1"

git commit config/Gemfile config/Gemfile.lock -m "Bundle update gem"
git push
