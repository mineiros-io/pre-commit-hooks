#!/usr/bin/env bash

set -e

for file in "$@"; do
    goimports -l -w "$(dirname "$file")"
done
