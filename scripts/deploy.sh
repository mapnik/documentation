#!/bin/bash

# set -o errexit -o nounset

echo $TRAVIS_BRANCH
SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

if [ "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]
then
  echo "Not a commit that we want to build. Only commits to the gh-pages branch will build."
  exit 0
fi

echo " - - - BRANCH VARS - - - "
REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
SHA=`git rev-parse --verify HEAD`
echo $REPO
echo $SSH_REPO
echo $SHA

# since we are doing this from the master branch, let's 
#  get a fresh clone ready, and set it to gh-pages
git clone $REPO out
cd out
git checkout $TARGET_BRANCH
cd ..

# copy over the newly rolled docs, from generate.sh
cp -r node-mapnik/ out/

# now go back into our fresh clone, with updated files
# and start getting things ready for the push
cd out
git config user.name "$GH_USERNAME"
git config user.email "$GH_EMAIL"

echo " - - - GIT STATUS - - - "
git status

git add --all
git commit -m "Update docs at ${SHA}"

ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key

git push $SSH_REPO $TARGET_BRANCH

exit 0