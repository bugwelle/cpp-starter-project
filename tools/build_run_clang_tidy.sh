#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

cd "${SCRIPT_PATH}/.."
source tools/utils.sh

print_info "Building with clang-tidy and applying fixes"

mkdir -p build
rm -rf build/*
cd build
cmake -S .. -B . -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
python3 /usr/lib/llvm-*/share/clang/run-clang-tidy.py -fix ../src
