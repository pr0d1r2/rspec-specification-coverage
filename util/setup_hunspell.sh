#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit $?

BASE_URL="https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en"

test -d .hunspell || mkdir .hunspell || exit $?

parallel \
  "test -f .hunspell/{} || curl $BASE_URL/{} -o .hunspell/{}" \
  ::: \
  en_US.aff en_US.dic

exit $?
