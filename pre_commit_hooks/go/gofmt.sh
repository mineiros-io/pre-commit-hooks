#!/usr/bin/env bash

set -e

# Make environment variables working in OSX GUI apps such as Github Desktop
# https://stackoverflow.com/q/135688/483528
export PATH=$PATH:/usr/local/bin

for file in "$@"; do
  go fmt  "./$(dirname "$file")"
done
