# CMake
CMake is a build system generator (it's not a build system per definition).
We use modern CMake which refers in our case to CMake 3.12 and above.

## What is "modern"?
DO NOT use `link_libraries()` or `include_directories()` without a `target_`
prefix. Modern CMake is target based.

These talks give a good introduction into modern CMake:

 - [CppCon 2017: Mathieu Ropert “Using Modern CMake Patterns to Enforce a Good Modular Design”](https://www.youtube.com/watch?v=eC9-iRN2b04)
 - [C++Now 2017: Daniel Pfeifer “Effective CMake" ](https://www.youtube.com/watch?v=bsXLMQ6WgIk)

I beg of you: Don't follow tutorials that only require CMake >= 2.8. You'll
only learn outdated CMake and it will **not** be fun. You will hate CMake.
Target based CMake is way easier. :-)

If you find projects that manage their sources using a global `PROJECT_SRC`
variable, it's outdated!
