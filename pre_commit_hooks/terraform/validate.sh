#!/usr/bin/env bash

set -e

# set default aws region for validating aws providers
export AWS_REGION=${AWS_REGION:="none"}

TF_VALIDATE_ERROR=0

while read -r dir; do
  echo "### Running 'terraform validate' in directory '$dir'"

  pushd "$dir" >/dev/null
  terraform init -backend=false || TF_VALIDATE_ERROR=$?
  terraform validate || TF_VALIDATE_ERROR=$?
  popd >/dev/null
done < <(printf '%s\n' "${@}" | xargs -n1 dirname | sort -u | uniq)

exit ${TF_VALIDATE_ERROR}
