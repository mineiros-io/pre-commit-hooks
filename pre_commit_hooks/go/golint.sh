#!/usr/bin/env bash

set -e

exit_status=0

for file in "$@"; do
    if ! golint -set_exit_status "$file"; then
        exit_status=1
    fi
done

exit ${exit_status}
