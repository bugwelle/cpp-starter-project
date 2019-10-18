#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

###############################################################################
# Run cppcheck on all sources (for usage in CIs)
# If you develop for this project, please use `make cppcheck`.
###############################################################################

cd "$( cd "$(dirname "$0")"; pwd -P )/.."
source tools/utils.sh

print_info "Run cppcheck on all source files"
cppcheck --enable=all --error-exitcode=1 -Isrc -j2 ./src
