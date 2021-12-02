# Packaging

Packaging is done using CMake.

## Example Usage

```sh
cmake -S . -B build/release -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=build/installed
cmake --build build/release
cd build/release
```
