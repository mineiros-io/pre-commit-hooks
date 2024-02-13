#!/usr/bin/env bash

set -e

if ! command -v tflint >/dev/null 2>&1; then
  echo >&2 "tflint is not available on this system."
  echo >&2 "Please visit https://github.com/terraform-linters/tflint for instructions on how to install."
  exit 1
fi

tflint_version=$(tflint -v | awk 'NR==1 { print $3 }' | awk -F. '{ print $1"."$2 }')
max_old_version="0.46"

if [[ $(tflint -v | awk -vmaxv=$max_old_version 'NR==1 { version=$3; if(version > maxv){print "true"} }') == "true" ]]; then
  if [[ ! -n "$CI" ]]; then
    tflint --init
  fi
  tflint
else
  for file in "$@"; do
    tflint "$file"
  done
fi
