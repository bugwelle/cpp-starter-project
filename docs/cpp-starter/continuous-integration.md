# Continuous Integration
No open-source project should start without using at least one continuous
integration service. It makes handling pull requests so much easier.
This projects tries to use as many CI services as possible.
We use:

 - [Travis CI](https://travis-ci.org/)
 - [AppVeyor](https://appveyor.com/)
 - [GitLab CI](https://gitlab.com/)

## Travis CI
Travis CI is free for open source projects. We use it for linux and macOS
builds. Because it's free, please refrain from creating *many* jobs that
take hours to complete. We use Travis CI for linux and macOS builds.

## AppVeyor
AppVeyor is free for oppen source projects. This project uses it for Windows
builds only.

## GitLab CI
GitLab CI is also available for GitHub projects. See its
[documentation](https://about.gitlab.com/solutions/github/) for set-up
instructions.

We use a custom docker image that is also hosted on GitLab. You can find it
at https://gitlab.com/bugwelle/docker-modern-cpp-cmake  
It includes recent versions of GCC and clang, cppcheck and other usefule tools.
By using custom docker images we could also use the latest C++ features
available, etc.
