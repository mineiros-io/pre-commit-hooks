#!/usr/bin/env bash

set -e

if ! command -v terradoc >/dev/null 2>&1; then
  echo >&2 "terradoc is not available on this system."
  echo >&2 "Please install it by running 'go install github.com/mineiros-io/terradoc/cmd/terradoc@latest'"
  exit 1
fi

terradoc generate $1 -o $2
