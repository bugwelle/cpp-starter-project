#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

cd "$( cd "$(dirname "$0")"; pwd -P )/.."
source tools/utils.sh

print_info "Format all files using clang-format"
# We currently don't format test files
find src tests \
    -type f \( -name "*.cpp" \
    -o -name "*.hpp" -o -name "*.h" \) \
    -exec clang-format \
    -i -style=file {} \;
