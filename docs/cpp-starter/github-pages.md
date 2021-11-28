# HowTo: GitHub Pages
It's actually quite simple to publish your sphinx documentation on GitHub.
I assume that you're on a linux distribution.

 1. create a *clean* new branch without any source code:
    `git checkout --orphan gh-pages`
 2. create an empty `.nojekyll` file (it tells GitHub to *not* use Jekyll),
    stage and commit it
 3. push the new and empty branch git GitHub
 4. run `./docs/user/publish_gh-pages.sh` which:
   - *resets* your branch to upstream (!)
   - copies the CHANGELOG and converts it to reStructuredText
   - creates URLs to GitHub issues (simple pattern matching `#nnn`)
   - creates sphinx documentation
   - copies the generated documentation to `gh-pages`
   - creates a new commit
   - pushes changes to GitHub
 5. Enable GitHub pages in your project's GitHub settings

All in one script:

```sh
cd project-root
git checkout --orphan gh-pages
git rm --cached -r . # Clear working directory
touch .nojekyll
git add .nojekyll
git commit -m "init gh-pages"
git push origin gh-pages
git checkout main
./docs/user/publish_gh-pages.sh
```
