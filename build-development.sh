#!/bin/bash

# WARNING: This is a quick hack that depends on the verison of python PDM installed
pdmdir=`pdm info |grep Packages | cut -d: -f2`
mergecmd="pdm run python ${pdmdir}/lib/rdfx/rdfx_cli.py"
pylodecmd="pdm run pylode"
files=$(cat tests/modules.txt | awk -F, '{print $2}')
shapefiles=$(cat tests/shapes.txt | awk -F, '{print $2}')
ONTOLOGY=ammo
SHACL=ammo.shacl

VERSION=` grep -i versionInfo modules/common/metadata.ttl | sed 's/[^"]*"\([^"]*\).*/\1/'`

if [ -f "./development/${ONTOLOGY}.ttl" ]; then
    rm ./development/${ONTOLOGY}.ttl
fi

if [ -f "./development/${SHACL}" ]; then
    rm  ./development/${SHACL}.ttl
fi

echo "Merging Ontology"
$mergecmd merge $files -f ttl -o ./development
mv ./development/merged.ttl ./development/${ONTOLOGY}.ttl
echo "Generating HTML Ontology Documentation"
$pylodecmd ./development/${ONTOLOGY}.ttl -o ./development/${ONTOLOGY}.html

echo "Merging Shapes"
$mergecmd merge $shapefiles -f ttl -o ./development
mv ./development/merged.ttl ./development/${SHACL}.ttl
echo "Generating HTML SHACL Shapes Documentation"
$pylodecmd ./development/${SHACL}.ttl -o ./development/${SHACL}.html
