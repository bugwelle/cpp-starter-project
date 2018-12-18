#!/usr/bin/env bash

set -e

###############################################################################
# Run cmake-format on all CMake files (for usage in CIs)
# If you develop for this project, please use `make cmake-format`.
###############################################################################

cd "$( cd "$(dirname "$0")"; pwd -P )/.."

echo "Run cmake-format on all CMake files"
find . -type f \
    \( -name "CMakeLists.txt" -o -name "*.cmake" \) \
    -exec cmake-format -c .cmake-format -i  {} +
