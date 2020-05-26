#!/usr/bin/env bash

set -e

if ! command -v markdown-link-check >/dev/null 2>&1; then
  echo >&2 "markdown-link-check is not available on this system."
  echo >&2 "Please install it by running 'npm install -g markdown-link-check'"
  exit 1
fi

TMP_CONFIG="$(mktemp)"
trap "rm -f $TMP_CONFIG;" EXIT

cat >"$TMP_CONFIG" <<EOF
{
  "replacementPatterns": [
    {
      "pattern": "^/",
      "replacement": "file://$(pwd)/"
    }
  ]
}
EOF

for file in "$@"; do
  markdown-link-check -c "$TMP_CONFIG" "$file"
done
