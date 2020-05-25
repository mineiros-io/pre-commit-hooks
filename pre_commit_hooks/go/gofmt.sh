#!/usr/bin/env bash

set -e

for file in "$@"; do
  go fmt  "./$(dirname "$file")"
done
