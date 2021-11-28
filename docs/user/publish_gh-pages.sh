#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

# cd into this file's directory
cd "$( cd "$(dirname "$0")"; pwd -P )"

# get a clean main branch
git checkout main
git pull origin main
git clean -df
git checkout -- .
git fetch --all

# build html docs from sphinx files
./create_changelog.sh
sphinx-build -M html source build

# create or use orphaned gh-pages branch
branch_name=gh-pages
if [ "$(git branch --list "$branch_name")" ]; then
    git stash
    git checkout $branch_name
    git pull origin $branch_name
    git checkout stash -- . 2> /dev/null || echo "Nothing on stash stack" # force git stash to overwrite added files

else
    echo "You need to create a branch '$branch_name' first."
    exit 1
fi

if [ -d "build" ]; then
    (ls | grep -v "build" | xargs rm -r) || echo "Nothing to clean"
    cd ../.. # is the root directory og GitHub Pages
    mv docs/user/build/html/* . && rm -rf "docs"
    git add .
    git commit -m "new pages version $(date)"
    git push origin gh-pages
    # github.com recognizes gh-pages branch and create pages
    # url scheme https//:[github-handle].github.io/[repository]
else
    echo "directory build does not exists"
fi

git checkout main
