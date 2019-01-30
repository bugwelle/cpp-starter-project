#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

cd "$( cd "$(dirname "$0")"; pwd -P )/.."

echo "Format all files using clang-format"
# We currently don't format test files
find . ! -path "./build/*" ! -path "./tests/*" ! -path "./third_party/*" \
    -type f \( -name "*.cpp" \
    -o -name "*.hpp" \) \
    -exec clang-format \
    -i -style=file {} \;
