#!/bin/bash

# set -e is considered to be a bad practice as written here http://mywiki.wooledge.org/BashFAQ/105
# so we use a trap instead
trap 'exit' ERR

# Make environment variables working in OSX GUI apps such as Github Desktop https://stackoverflow.com/q/135688/483528
export PATH=$PATH:/usr/local/bin

# set default aws region for validating aws providers
export AWS_REGION=${AWS_REGION:="none"}

for dir in $(echo "$@" | xargs -n1 dirname | sort -u | uniq); do
  terraform init -backend=false "$dir"
  terraform validate "$dir"
done
