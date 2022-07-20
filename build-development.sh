#!/bin/bash

# WARNING: This is a quick hack that depends on the verison of python PDM installed
pdmdir=`pdm info --packages`
mergecmd="pdm run python ${pdmdir}/lib/rdfx/rdfx_cli.py"
pylodecmd="pdm run pylode"
files=$(cat tests/modules.txt | awk -F, '{print $2}')
shapefiles=$(cat tests/shapes.txt | awk -F, '{print $2}')
ONTOLOGY=ammo
SHACL=ammo.shacl

VERSION=` grep -i versionInfo modules/common/metadata.ttl | sed 's/[^"]*"\([^"]*\).*/\1/'`

if [ -f "./development/ontology/merged.ttl" ]; then
    rm ./development/ontology/merged.ttl
fi

echo "Merging Ontology"
$mergecmd merge $files -f ttl -o ./development/ontology

# echo "Merging Shapes"
# $mergecmd merge $shapefiles -f ttl -o ./development/raw
#echo "Generating HTML SHACL Shapes Documentation"
# $pylodecmd ./development/${SHACL}.ttl -o ./development/${SHACL}.html

echo "Generating HTML Ontology Documentation"
docker run -ti --rm   -v `pwd`/development/ontology:/usr/local/widoco/in   -v `pwd`/development/ontology:/usr/local/widoco/out/doc   dgarijo/widoco -ontFile in/merged.ttl -outFolder out -rewriteAll -webVowl 
# Clean up temp merged file
if [ -f "./development/ontology/merged.ttl" ]; then
    rm ./development/ontology/merged.ttl
fi