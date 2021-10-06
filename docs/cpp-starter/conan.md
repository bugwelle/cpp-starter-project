# conan Package Manager
We use [conan](https://conan.io/) to manage our C++ dependencies.

## Why conan and not X?
As far as I can tell conan is the most commonly used C++ package manager that
I found. [vcpkg](https://github.com/Microsoft/vcpkg) may be another good option
but I've choosen conan because I like it. :-)

## How do I use it?
 1. [install conan](https://docs.conan.io/en/latest/installation.html#install-with-pip-recommended)
 2. create a build directory (`mkdir build && cd $_`)
 3. run cmake with a build type (`cmake -DCMAKE_BUILD_TYPE=Debug ..`) as this will
    also install all dependencies using conan

That's it for this project. Some tips about a few problems I had:

 - `conan search my-package` is case sensitive on linux. I got that wrong
   because conan also has a command line option `--case-sensitive` which is
   only effective on windows (it seems).
 - correct include paths are not determined by the package's name but by the
   package itself. For `range-v3` the correct include path wasn't 
   `range-v3/all.hpp` but instead `range/v3/all.hpp`. I had to look at
   https://github.com/ericniebler/range-v3/tree/master/include/range/v3 to
   find the correct path.
 - You can manage different profiles for different compilers. That may be
   difficult at first... TODO

For more information about conan, please refer to its
[documentation](https://docs.conan.io/en/latest/introduction.html).
