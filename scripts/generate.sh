# generates Node Mapnik documentation using documentationjs


VERSION=$1
echo "VERSION: ${VERSION}"

touch testfile.txt

# cd node_modules/documentation
# npm link
# cd ../..

# CONFIG=config/node.json
# THEME=node_modules/node-mapnik-theme/
# SOURCE=node_modules/mapnik/src/*.cpp
# SINK=./node-mapnik/${VERSION}

# documentation build ${SOURCE} --polyglot -f html -o ${SINK} --github --name "Node Mapnik" --theme ${THEME} --config ${CONFIG}