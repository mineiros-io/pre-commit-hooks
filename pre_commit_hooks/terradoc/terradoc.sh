#!/usr/bin/env bash

set -e

if hash terradoc 2>/dev/null; then
  for file in "$@"; do
    terradoc generate -o "./$(dirname "$file")" "./$(dirname "$file")"
  done
else
    echo "Couldn't find terradoc executable in your $PATH. Seems like terradoc isn't installed." && exit 1
fi
