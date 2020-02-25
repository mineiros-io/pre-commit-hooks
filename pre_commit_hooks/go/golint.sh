#!/usr/bin/env bash

set -e

# Make environment variables working in OSX GUI apps such as Github Desktop
# https://stackoverflow.com/q/135688/483528
export PATH=$PATH:/usr/local/bin

exit_status=0

for file in "$@"; do
    if ! golint -set_exit_status "$file"; then
        exit_status=1
    fi
done

exit ${exit_status}
