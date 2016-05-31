#!/bin/bash

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "gh-pages" ]
then
  echo "Not a commit that we want to build. Only commits to the gh-pages branch will build."
  exit 0
fi

rev=$(git rev-parse --short HEAD)

git init
git config user.name "$GH_USERNAME"
git config user.email "$GH_EMAIL"
git remote add upstream "https://$GH_TOKEN@github.com/mapnik/documentation.git"
git fetch upstream
git reset upstream/gh-pages

git add .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages