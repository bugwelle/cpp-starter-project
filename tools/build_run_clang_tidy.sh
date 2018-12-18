#!/usr/bin/env bash

set -e

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

cd "${SCRIPT_PATH}/.."

echo "Building with clang-tidy and applying fixes"

mkdir -p build
rm -rf build/*
cd build
conan install ..
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
python3 /usr/lib/llvm-*/share/clang/run-clang-tidy.py -fix ../src