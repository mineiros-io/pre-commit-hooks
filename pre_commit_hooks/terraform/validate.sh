#!/bin/bash
set -e

# Make environment variables working in OSX GUI apps such as Github Desktop
# https://stackoverflow.com/q/135688/483528
export PATH=$PATH:/usr/local/bin

# set default aws region for validating aws providers
export AWS_REGION=${AWS_REGION:="none"}

for dir in $(echo "$@" | xargs -n1 dirname | sort -u | uniq); do
  terraform init -backend=false "$dir"
  terraform validate "$dir"
done
