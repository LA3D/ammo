#!/bin/bash

# WARNING: This is a quick hack that depends on the verison of python PDM installed
pdmdir=`pdm info --packages`
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
if [ ! -d "./release/ontology/${VERSION}" ]; then
    mkdir -p ./release/ontology/${VERSION}
else
    rm -rf ./release/ontology/${VERSION} 
    mkdir -p ./release/ontology/${VERSION}
fi

if [ ! -d "./release/shapes/shacl/${VERSION}" ]; then
    mkdir -p ./release/shapes/shacl/${VERSION}
else
   rm -rf ./release/shapes/shacl/${VERSION}
   mkdir -p ./release/shapes/shacl/${VERSION}
fi

# Clean latest
if [ -d "./release/ontology/latest" ]; then
    rm -rf ./release/ontology/latest
fi
if [ -d "./release/shapes/shacl/latest" ]; then
    rm -rf ./release/shapes/shacl/latest
fi

echo "Merging Ontology into Release ${VERSION}"
$mergecmd merge $files -f ttl -o ./release/ontology/${VERSION}

echo "Generating Ontology Documentation via Widoco"
docker run -ti --rm   -v `pwd`/release/ontology/${VERSION}:/usr/local/widoco/in   -v `pwd`/release/ontology/${VERSION}:/usr/local/widoco/out/doc   dgarijo/widoco -ontFile in/merged.ttl -outFolder out -rewriteAll -webVowl 

if [ -d "./release/ontology/latest" ]; then
    rm -rf ./release/ontology/latest
    cp -r ./release/ontology/${VERSION} ./release/ontology/latest
else
    cp -r ./release/ontology/${VERSION} ./release/ontology/latest
fi

echo "Merging SHACL Shapes into Release ${VERSION}"
$mergecmd merge $shapefiles -f ttl -o ./release/shapes/shacl/${VERSION}
#echo "Generating HTML SHACL Shapes Documentation for Release ${VERSION}"
#$pylodecmd ./release/shapes/shacl/${VERSION}/${SHACL}.ttl -o ./release/shapes/shacl/${VERSION}/${SHACL}.html

echo "Generating Shapes Documentation via Widoco"
docker run -ti --rm   -v `pwd`/release/shapes/shacl/${VERSION}:/usr/local/widoco/in   -v `pwd`/release/shapes/shacl/${VERSION}:/usr/local/widoco/out/doc   dgarijo/widoco -ontFile in/merged.ttl -outFolder out -rewriteAll -webVowl 
if [ -d "./release/shapes/shacl/latest" ]; then
    rm -rf ./release/shapes/shacl/latest
    cp -r ./release/shapes/shacl/${VERSION} ./release/shapes/shacl/latest
else
    cp -r ./release/shapes/shacl/${VERSION} ./release/shapes/shacl/latest
fi