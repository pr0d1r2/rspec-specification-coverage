#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")/.."

pgrep -f "$HOME/.rbenv/versions/$RUBY_VERSION/bin/guard" | xargs kill

bundle exec overcommit --sign

TMP_FILE="$(mktemp)"
echo "An example good commit message" > "$TMP_FILE"
bundle exec overcommit --run CommitMsg "$TMP_FILE"
rm -f "$TMP_FILE"

# shellcheck disable=SC2013
for CHECK in $(grep -v "^ " .overcommit.yml | \
  grep -v "^---$" | \
  grep -v "^$" | \
  cut -f 1 -d : | \
  grep -v "^CommitMsg$")
do
  bundle exec overcommit --run "$CHECK"
done

bundle exec overcommit --run
