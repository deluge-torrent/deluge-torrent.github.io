#!/usr/bin/env bash
git checkout develop
git remote update
ret=`git diff @{u}` # Diff the tracking branch
if [ -z "$ret" ]; then
    git checkout deluge-github-page
    exit
fi
git pull
tox -e testcoverage-html
git checkout deluge-github-page
rm -rf htmlcoverage
cp -r docs/build/htmlcoverage htmlcoverage
git add htmlcoverage/
git commit -m "Updated htmlcoverage" -a
git push deluge-gh-page-remote deluge-github-page:master
rm -rf docs/build
git checkout deluge-github-page
