#!/usr/bin/env bash

set -e

for file in "$@"; do
  tflint "$file"
done
