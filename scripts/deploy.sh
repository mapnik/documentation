#!/bin/bash

set -o errexit -o nounset

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

if [ "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]
then
  echo "Not a commit that we want to build. Only commits to the gh-pages branch will build."
  exit 0
fi

REPO=`git config remote.origin.url`
SHA=`git rev-parse --verify HEAD`

# since we are doing this from the master branch, let's 
#  get a fresh clone ready, and set it to gh-pages
git clone $REPO out
cd out
git checkout $TARGET_BRANCH
cd ..

# copy over the newly rolled docs, from scripts/generate.sh
cp -r node-mapnik/ out/

# now go back into our fresh clone, with updated files
# and start getting things ready for the push
cd out
git config user.name "$GH_USERNAME"
git config user.email "$GH_EMAIL"

git add --all # dangerous? risky business? WATCH OUT!
git commit -m "Update docs at ${SHA}"
git push "https://$GITHUB_AUTH@github.com/mapnik/documentation.git" $TARGET_BRANCH

exit 0