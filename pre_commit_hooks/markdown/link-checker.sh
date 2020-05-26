#!/usr/bin/env bash

set -e

if ! command -v markdown-link-check; then
  >&2 echo "markdown-link-check is not available on this system."
  >&2 echo "Please install it by running 'npm install -g markdown-link-check'"
  exit 1
fi

TMP_CONFIG="$(mktemp)"
echo $TMP_CONFIG
trap "rm -f $TMP_CONFIG;" EXIT

cat > "$TMP_CONFIG" <<EOF
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
