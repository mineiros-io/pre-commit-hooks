#!/usr/bin/env bash

set -e

if hash golangci-lint 2>/dev/null; then
    golangci-lint run --fix "$@"
else
    echo "Couldn't find golangci-lint executable in your $PATH. Seems like golangci-lint isn't installed." && exit 1
fi
