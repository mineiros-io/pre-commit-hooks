#!/bin/bash
set -e

# Make environment variables working in OSX GUI apps such as Github Desktop
# https://stackoverflow.com/q/135688/483528
export PATH=$PATH:/usr/local/bin

# set default aws region for validating aws providers
export AWS_REGION=${AWS_REGION:="none"}

while read dir; do
  terraform init -backend=false "$dir"
  terraform validate "$dir"
done < <(printf '%s\n' "${@%/*}" | sort -u)
