#!/usr/bin/env bash

set -e
set -u 
set -o pipefail

# shellcheck disable=SC2155,SC2034
readonly ARGS=("$@")

function is_binary_available() {
  local bin_list=( terradoc )
  for b in "${bin_list[@]}"; do
    if [ -x "$(type -p "${b}")" ]; then
      declare -g "_${b}"="$(type -p "${b}")"
    else
      echo >&2 "The executable ${b} is missing"
      exit 1
    fi
  done
}

main() {
  is_binary_available

  for filename in "${ARGS[@]}"; do
    # shellcheck disable=SC2154
    "${_terradoc}" fmt -w "${filename}"
  done
}
# Run script
main
