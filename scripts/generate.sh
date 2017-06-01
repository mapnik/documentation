# generates Node Mapnik documentation using documentationjs

# get the full version and parse out the minor version
FULL_VERSION=$(node -e "console.log(require('./node_modules/mapnik/package.json').version)")
MINOR_VERSION=$(node -e "console.log('$FULL_VERSION'.slice(0, '$FULL_VERSION'.lastIndexOf('.')))")
echo "Building $MINOR_VERSION from mapnik version $FULL_VERSION"

# make sure the documentation CLI works
cd node_modules/documentation
npm link
cd ../..

# documentation.js arguments
CONFIG=config/node.json
THEME=node_modules/node-mapnik-theme/
SOURCE=node_modules/mapnik/src/*.cpp
SINK=./node-mapnik/${MINOR_VERSION}

# build the documentation in the folder named after the minor version
documentation build ${SOURCE} --polyglot -f html -o ${SINK} --github --name "Node Mapnik" --theme ${THEME} --config ${CONFIG}

# regenerate the index.html file to forward to the most recent minor version
HTML="<!DOCTYPE html><html><head><meta http-equiv='content-type' content='text/html; charset=utf-8' /><meta http-equiv='refresh' content='0;url=$MINOR_VERSION/' /></head></html>"
echo $HTML > ./node-mapnik/index.html
