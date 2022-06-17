#!/bin/bash

# WARNING: This is a quick hack that depends on the verison of python PDM installed
pdmdir=`pdm info |grep Packages | cut -d: -f2`
mergecmd="pdm run python ${pdmdir}/lib/rdfx/rdfx_cli.py"
pylodecmd="pdm run pylode"
files=$(cat tests/modules.txt | awk -F, '{print $2}')
shapefiles=$(cat tests/shapes.txt | awk -F, '{print $2}')
ONTOLOGY=ammo
SHACL=ammo.shacl

JENAVERSION="4.5.0"

if [ -f "./apache-jena-${JENAVERSION}/bin/riot" ]; then
    RIOT="./apache-jena-${JENAVERSION}/bin/riot"
else
    RIOT="riot"
fi

VERSION=` grep -i versionInfo modules/common/metadata.ttl | sed 's/[^"]*"\([^"]*\).*/\1/'`

# Make sure the version directory exists
if [ ! -d "./release/${VERSION}" ]; then
    mkdir ./release/${VERSION}
fi

if [ -f "./release/${VERSION}/${ONTOLOGY}" ]; then
    rm ./release/${VERSION}/${ONTOLOGY}.ttl
fi

if [ -f "./release/${VERSION}/${SHACL}" ]; then
    rm  ./release/${VERSION}/${SHACL}.ttl
fi

echo "Merging Ontology into Release ${VERSION}"
$mergecmd merge $files -f ttl -o ./release/${VERSION}
mv ./release/${VERSION}/merged.ttl ./release/${VERSION}/${ONTOLOGY}.ttl
echo "Generating HTML Ontology Documentation for Release ${VERSION}"
$pylodecmd ./release/${VERSION}/${ONTOLOGY}.ttl -o ./release/${VERSION}/${ONTOLOGY}.html

echo "Merging SHACL Shapes into Release ${VERSION}"
$mergecmd merge $shapefiles -f ttl -o ./release/${VERSION}
mv ./release/${VERSION}/merged.ttl ./release/${VERSION}/${SHACL}.ttl
echo "Generating HTML SHACL Shapes Documentation for Release ${VERSION}"
$pylodecmd ./release/${VERSION}/${SHACL}.ttl -o ./release/${VERSION}/${SHACL}.html

# Generate other RDF serializations using Jena RIOT
$RIOT -out N-TRIPLE ./release/${VERSION}/${ONTOLOGY}.ttl > ./release/${VERSION}/${ONTOLOGY}.nt
$RIOT -out RDF/XML  ./release/${VERSION}/${ONTOLOGY}.ttl > ./release/${VERSION}/${ONTOLOGY}.xml
$RIOT -out JSON-LD  ./release/${VERSION}/${ONTOLOGY}.ttl > ./release/${VERSION}/${ONTOLOGY}.json

# Copy 406.html to release directory
cp ./release/406.html ./release/${VERSION}/406.html


if [ -d "./release/latest" ]; then
    rm -rf ./release/latest
    cp -r ./release/${VERSION} ./release/latest
else
    cp -r ./release/${VERSION} ./release/latest
fi