# generates Node Mapnik documentation using documentationjs

VERSION=$1

cd node_modules/documentation
npm link
cd ../..

CONFIG=./config/node.json
THEME=./node_modules/node-mapnik-theme/
SOURCE=./node_modules/mapnik/src/*.*pp
SINK=./node-mapnik/${VERSION}

# generate docs
documentation build ${SOURCE} --polyglot -f html -o ${SINK} --github --name "Node Mapnik" --theme ${THEME} --config ${CONFIG}