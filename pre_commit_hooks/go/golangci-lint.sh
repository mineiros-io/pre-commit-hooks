#!/usr/bin/env bash

set -e

# Make environment variables working in OSX GUI apps such as Github Desktop
# https://stackoverflow.com/q/135688/483528
export PATH=$PATH:/usr/local/bin

if hash golangci-lint 2>/dev/null; then
    golangci-lint run --enable-all --fix "$@"
else
    echo "Couldn't find golangci-lint executable in your $PATH. Seems like golangci-lint isn't installed." && exit 1
fi
