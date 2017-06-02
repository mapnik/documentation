# Generates Node Mapnik documentation by cloning the node-mapnik
# repository and running documentationjs commands
set -eu

REPO="https://github.com/mapnik/node-mapnik.git"
BRANCH="v3.4.19"

# clone node-mapnik master to get current gisha and minor version
# this is used to build proper source links in the documentation
# and set the minor version (i.e. 3.5) for building a proper
# directory for docs to live
TMP_REPO=./tmp-node-mapnik-repo
git clone --branch $BRANCH $REPO $TMP_REPO --depth 1 && cd $TMP_REPO
NODE_MAPNIK_GITSHA=`git rev-parse --verify HEAD`
FULL_VERSION=$(node -e "console.log(require('./package.json').version)")
MINOR_VERSION=$(node -e "console.log('$FULL_VERSION'.slice(0, '$FULL_VERSION'.lastIndexOf('.')))")
echo "Building $MINOR_VERSION from mapnik version $FULL_VERSION"
cd ../

# build the documentation in the folder named after the minor version
# documentation.js arguments
CONFIG=config/node.json
THEME=./theme
SOURCE=$TMP_REPO/src/*.cpp
SINK=./node-mapnik/${MINOR_VERSION}

NODE_MAPNIK_GITSHA=$NODE_MAPNIK_GITSHA ./node_modules/documentation/bin/documentation.js build ${SOURCE} \
  --polyglot \
  -f html \
  -o ${SINK} \
  --github \
  --name "Node Mapnik" \
  --theme ${THEME} \
  --config ${CONFIG}

# regenerate the index.html file to forward to the most recent minor version
HTML="<!DOCTYPE html><html><head><meta http-equiv='content-type' content='text/html; charset=utf-8' /><meta http-equiv='refresh' content='0;url=$MINOR_VERSION/' /></head></html>"
echo $HTML > ./node-mapnik/index.html

# remove tmp node-mapnik repository cloned above
rm -rf ./tmp-node-mapnik-repo

exit 0
