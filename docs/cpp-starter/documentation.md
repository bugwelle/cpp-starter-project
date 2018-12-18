# HowTo: Documentation
I find it difficult to create good documentation. We begin with some basics:

 - user documentation
 - developer documentation

If you develop an end-user executable then documentation for them is a must-
have. Developers on the other hand want to read your code, want to improve
stuff. Personally I like doxygen as it is more or less standard.


## User Documentation
Sphinx is a tool that makes it easy to create beautiful documentation.
We use it in combination with the
[Read The Docs Sphinx Theme](https://sphinx-rtd-theme.readthedocs.io/en/latest/).


## Developer Documentation
This project uses [doxygen](http://doxygen.nl/). Many projects include a
`Doxyfile` that is used by the `doxygen` command-line tool. We instead
use some CMake built-ins. Have a look at [CMakeLists.txt](./CMakeLists.txt).
You can create this project's doxygen documentation using `make docs`.
