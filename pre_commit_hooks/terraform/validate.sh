#!/usr/bin/env bash

set -e

# set default aws region for validating aws providers
export AWS_REGION=${AWS_REGION:="none"}

while read -r dir; do
  terraform init -backend=false "$dir"
  terraform validate "$dir"
done < <(printf '%s\n' "${@}" | xargs -i dirname {} | sort -u)
