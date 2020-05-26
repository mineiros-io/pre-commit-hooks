#!/usr/bin/env bash

set -e

EXITCODE=0

validate_phony_targets() {
    local file
    local source
    local targets

    file=$1
    source=$(make -npq -f "${file}" | grep -E '^.PHONY:')
    targets=$(sed -n 's#^.PHONY:\(.*\)#\1#p' <<<"${source}")

    for target in $targets; do
        # The q command for setting exit codes if a pattern doesn't match,
        # isn't supported in OSX / BSD sed.
        # We check the exact match as a workaround instead.
        # If the pattern doesn't match that means that the target doesn't exist.
        if test -z "$(sed -ne "s#^\(${target}:\).*#\1#p" "${file}")"; then
            echo "No target found for PHONY target: '$target'"
            EXITCODE=1
        fi
    done
}

for file in "$@"; do
    validate_phony_targets "$file"
done

exit $EXITCODE
