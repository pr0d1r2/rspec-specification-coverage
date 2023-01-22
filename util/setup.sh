#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")/.."

util/setup_hunspell.sh

bundle install
bundle exec overcommit --install
