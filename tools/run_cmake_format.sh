#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

###############################################################################
# Run cmake-format on all CMake files (for usage in CIs)
# If you develop for this project, please use `make cmake-format`.
###############################################################################

cd "$( cd "$(dirname "$0")"; pwd -P )/.."
source tools/utils.sh

print_info "Run cmake-format on all CMake files"
find . -type f \
    ! -path "./build/*" \
    \( -name "CMakeLists.txt" -o -name "*.cmake" \) \
    -exec cmake-format -c .cmake-format -i  {} +
