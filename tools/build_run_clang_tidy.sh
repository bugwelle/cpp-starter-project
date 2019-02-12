#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

cd "${SCRIPT_PATH}/.."

echo "Building with clang-tidy and applying fixes"

mkdir -p build
rm -rf build/*
cd build
cmake -DCMAKE_BUILD_TYPE=Debug \
    -DENABLE_COTIRE=OFF \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
python3 /usr/lib/llvm-*/share/clang/run-clang-tidy.py -fix ../src
