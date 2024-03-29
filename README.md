[![Codacy Badge](https://app.codacy.com/project/badge/Grade/d6cd38c4a97341f79b1712548444e703)](https://www.codacy.com/gh/bugwelle/cpp-starter-project/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=bugwelle/cpp-starter-project&amp;utm_campaign=Badge_Grade)
[![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE)
[![Travis CI Build Status](https://app.travis-ci.com/bugwelle/cpp-starter-project.svg?branch=main)](https://app.travis-ci.com/bugwelle/cpp-starter-project)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/j56v8bgwtk24tuu9/branch/main?svg=true)](https://ci.appveyor.com/project/archer96/cpp-starter-project/branch/main)[![GitLab CI Pipeline Status](https://img.shields.io/gitlab/pipeline/bugwelle/cpp-starter-project.svg?logo=gitlab)](https://gitlab.com/bugwelle/cpp-starter-project/pipelines)
[![codecov](https://codecov.io/gh/bugwelle/cpp-starter-project/branch/main/graph/badge.svg)](https://codecov.io/gh/bugwelle/cpp-starter-project)


# cpp-starter-project

**This project is not finished, yet!**  
**Even if this readme says that it uses/supports X, that may not be the case, yet!**

`cpp-starter-project` is a personal starter project for modern C++ development.
Its goal is to offer a set of modern tools and resources to interested
developers (e.g. students) that want to create executable programs. This
project is not intended for creating libraries.

## Why?
I found many C++ starter projects and even more tutorials that give a
good introduction into starting new C++ and [CMake][cmake] projects but none
of them were either up-to-date (speaking C++20 and CMake >= 3.12) or had all
features that I'd like to have like package managers or continuous integration.


## Documentation
Documentation about how this starter project is structured and which continuous
integration services, etc. are used can be found in
[`docs/cpp-starter`](docs/cpp-starter/README.md).

Generated Sphinx documentation can be found at <https://bugwelle.github.io/cpp-starter-project/>


## Features
This project aims to be a full-fledged entry point for new medium-sized projects.  
Following features are included:

 - [x] project structure common to C++ projects (similar to [pitchfork][pf])
 - [x] modern C++ (currently C++20)
 - [x] modern CMake >= 3.12
     (no more `include_directories(...)` or `link_libraries(...)`)
 - [x] testing framework ([Catch2][catch2])
 - [x] user documentation using [Doxygen][doxygen] and [Sphinx][sphinx]
 - [x] documentation using [Doxygen][doxygen] and [Sphinx][sphinx]
 - [x] [GitHub Pages][ghpages] on `gh-pages` branch
 - [x] code formatting because no one has got time for that in code reviews
     ([`clang-format`][clangfmt] and [`cmake-format`][cmakefmt])
 - [x] static code analysis tools like linters
     ([`cppcheck`](cppcheck), [`clang-tidy`][clangtidy], [`shellcheck`][shcheck])
 - [x] continuous integration: useful not only for pull requests
     ([Travis CI][travis], [AppVeyor][appveyor], [GitLab CI][gitlabci])
 - [ ] continuous deployment to [GitHub Pages][githubpg]
 - [x] code coverage using [Codecov][codecov]
 - [ ] CPack script for packaging

## What's not included?
This project no longer uses Conan as package manager.  I've also not included VCPKG or other package
managers.  None are perfect, all have their drawbacks.  If you want to use Conan, you can still do so.
Please refer to their "[Getting started](https://docs.conan.io/en/latest/getting_started.html)" guide.

## Inspiration
This project was inspired by:

 - https://github.com/abdes/asap
 - https://github.com/lefticus/cpp_starter_project
 - https://github.com/ttroy50/cmake-examples
 - https://github.com/kartikkumar/cppbase
 - https://github.com/richelbilderbeek/travis_cpp_tutorial
 - https://github.com/codecov/example-cpp11-cmake
 - https://github.com/cginternals/cmake-init
 - https://github.com/LearningByExample/ModernCppCI
   (https://juan-medina.com/2017/07/01/moderncppci/)


## License
See [`LICENSE`](LICENSE). This project contains third-party software like CMake
modules and C++ libraries. See section "Third Party".


## Third Party
This project uses:

 - Catch2
   - Website: https://github.com/catchorg/Catch2
   - License: [Boost Software License 1.0](https://github.com/catchorg/Catch2/blob/master/LICENSE.txt)
   - Reason: Testing framework
 - range-v3
   - Website: https://github.com/ericniebler/range-v3
   - License: [Boost Software License 1.0](https://github.com/ericniebler/range-v3/blob/master/LICENSE.txt)
   - Reason: C++ ranges implementation

We also use some CMake modules. See `cmake/README.md`.


## Notes
Because we use range-v3 and other modern C++ features, we only support these compilers:

 - Windows
   - MSVC 2017 version >= 15.9
   - TODO: MinGW64
 - macOS
   - TODO: clang
   - TODO: GCC
 - linux
   - TODO: clang
   - TODO: GCC

[appveyor]:  https://ci.appveyor.com/project/archer96/cpp-starter-project
[catch2]:    https://github.com/catchorg/Catch2
[clangfmt]:  https://clang.llvm.org/docs/ClangFormat.html
[clangtidy]: https://clang.llvm.org/extra/clang-tidy/
[cmake]:     https://cmake.org/
[cmakefmt]:  https://github.com/cheshirekow/cmake_format
[codecov]:   https://codecov.io/
[cppcheck]:  http://cppcheck.sourceforge.net/
[doxygen]:   http://www.doxygen.nl/
[ghpages]:   https://bugwelle.github.io/cpp-starter-project/
[githubpg]:  https://github.com/bugwelle/cpp-starter-project/releases
[gitlabci]:  https://gitlab.com/bugwelle/cpp-starter-project/pipelines
[pf]:        https://github.com/vector-of-bool/pitchfork
[shcheck]:   https://www.shellcheck.net/
[sphinx]:    http://www.sphinx-doc.org/en/stable/
[travis]:    https://travis-ci.org/bugwelle/cpp-starter-project
