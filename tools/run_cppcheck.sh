#!/usr/bin/env bash

set -e

###############################################################################
# Run cppcheck on all sources (for usage in CIs)
# If you develop for this project, please use `make cppcheck`.
###############################################################################

cd "$( cd "$(dirname "$0")"; pwd -P )/.."

echo "Run cppcheck on all source files"
cppcheck --enable=all --error-exitcode=1 -Isrc -j2 ./src
