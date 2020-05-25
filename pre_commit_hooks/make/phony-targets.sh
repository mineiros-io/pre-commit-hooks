#!/usr/bin/env bash

set -e

# Make environment variables working in OSX GUI apps such as Github Desktop
# https://stackoverflow.com/q/135688/483528
export PATH=$PATH:/usr/local/bin

EXITCODE=0

validate_phony_targets() {
    local source=$1
    local targets=$(sed -n 's#^.PHONY:\(.*\)#\1#p' <<< $source)

    for target in $targets; do
        # The q command for setting exit codes if a pattern doesn't match,
        # isn't supported in OSX / BSD sed.
        # We check the exact match as a workaround instead.
        # If the pattern doesn't match that means that the target doesn't exist.
        if test -z "$(sed -ne "s#^\(${target}:\).*#\1#p" <<< $source)"
        then
            echo "No target found for PHONY target: '$target'"
            EXITCODE=1
        fi
    done
}

for file in "$@"; do
    SOURCE="$(cat $file)"
    validate_phony_targets "$SOURCE"
done

exit $EXITCODE


