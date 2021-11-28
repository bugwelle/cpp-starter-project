# Contributing

## Project Requirements

This project uses many (modern) tools, so you may need to install quite a lot first.

You need to install:

 - [CMake](https://cmake.org/)
 - [Conan](https://conan.io/)
 - [Visual Studio 15](https://visualstudio.microsoft.com/) or
   [MinGW 64](https://mingw-w64.org/doku.php)

Following tools are optional but recommended:
 - [Doxygen](http://www.doxygen.nl/)
 - [`clang-tidy`](https://clang.llvm.org/extra/clang-tidy/)
 - [`clang-format`](https://clang.llvm.org/docs/ClangFormat.html)
 - [`cmake-format`](https://github.com/cheshirekow/cmake_format)
 - [Cppcheck](http://cppcheck.sourceforge.net/)

### Install Requirements on Ubuntu

These instructions were tested on Ubuntu 18.04:

```sh
pip3 install conan cmake_format
sudo apt install doxygen doxygen-doc
sudo apt install shellcheck
sudo apt install gcc g++
sudo apt install clang clang++ clang-format clang-tidy
```

## CMake Targets

Following build targets are available:

```sh
make              # Build all targets
make cmake-format # Format all CMake files according to .cmake-format
make coverage     # Create code coverage
make cppcheck     # Run a linter for C++
make docs         # Create user documentation
make doxygen      # Create developer documentation
make shellcheck   # Lints all bash scripts
make test         # Run all tests (`ctest` works as well)
```

## Building

### Linux & macOS

```sh
cd cpp-starter-project
mkdir build && cd $_
# Also installs third party dependencies using conan
cmake -DCMAKE_BUILD_TYPE=Debug ..
make -j$(nproc)
```

### Windows

```sh
cd cpp-starter-project
mkdir build
cd build
conan user
cmake -DCMAKE_BUILD_TYPE=Debug -G "Visual Studio 15 2017 Win64" .. # or "MinGW Makefiles"
cmake --build . --config "Debug"
```

## Testing

```sh
# Test
cmake ..
# Note: CMake >= 3.12 supports -jN, so we don't need to pass to to `make`
cmake --build . -j 2
ctest .

# Create coverage
cmake -DENABLE_COVERAGE:BOOL=ON ..
cmake --build . -j 2 -- coverage
```

## Sanitizers

This project can be build using multiple sanitizers.
Just pass one of these options to CMake.

```sh
cmake -DSANITIZE_ADDRESS=ON   ..
cmake -DSANITIZE_THREAD=ON    ..
cmake -DSANITIZE_UNDEFINED=ON ..
CXX=clang++ CC=clang cmake -DSANITIZE_MEMORY=ON ..
```

The memory sanitizer is as of now (2018-12-18) only available for clang.

## Branching policy

Currently, all work is done on the `main` branch.
For each change that you want to submit by creating a new pull requests,
please create a new branch that has a meaningful name, e.g. `fix-memory-leak`
or `fix-nn` where `nn` is the id of an GitHub issue.

## Submitting code

Submitted code should follow these quality guidelines:

 - all Travis CI stages pass
 - all GitLab CI jobs pass
 - all AppVeyor jobs pass
 - code should adhere to project standards

If anything breaks, you'll get notified on each pull request.
