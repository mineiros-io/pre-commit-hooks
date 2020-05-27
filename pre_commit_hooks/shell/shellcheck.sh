#!/usr/bin/env bash

set -e

if ! command -v shellcheck >/dev/null 2>&1; then
    echo >&2 'shellcheck is not available on this system.'
    echo >&2 "Please install it by running e.g. 'brew install shellcheck'"
    exit 1
fi

shellcheck "$@"
