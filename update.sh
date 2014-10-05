#!/usr/bin/env bash
git checkout develop
git remote update
ret=`git diff @{u}` # Diff the tracking branch
if [ -z "$ret" ]; then
    exit
fi
git pull
tox -e testcoverage-html
git checkout master
rm -rf htmlcoverage
cp -r docs/build/htmlcoverage htmlcoverage
git add htmlcoverage/
git commit -m "Update htmlcoverage" -a
git push
rm -rf docs/build
