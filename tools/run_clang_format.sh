#!/usr/bin/env bash

set -Eeuo pipefail
IFS=$'\n\t'

# Go to project directory
cd "$(dirname "${BASH_SOURCE[0]}")/.." > /dev/null 2>&1

source tools/utils.sh

# Explicitly use clang-format in version 12.
# As I use macOS with MacPorts, we search for it as well.
if [[ -x "$(command -v clang-format-12)" ]]; then
	CF=clang-format-12
elif [[ -x "$(command -v clang-format-mp-12)" ]]; then
	# MacPorts version
	CF=clang-format-mp-12
else
	CF=clang-format
	clang-format --version | grep " 12." > /dev/null || (print_warning "WARNING: MediaElch requires clang-format version 12")
fi

print_important "Format all source files using ${CF}"
find src tests \
    -type f \( -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) \
    -exec ${CF} \
    -i -style=file {} \+

print_success "Done"
