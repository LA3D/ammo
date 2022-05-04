#!/bin/bash

# WARNING: This is a quick hack that depends on the verison of python PDM installed
pdmdir=`pdm info |grep Packages | cut -d: -f2`
mergecmd="pdm run python ${pdmdir}/lib/rdfx/rdfx_cli.py"
pylodecmd="pdm run pylode"
files='./modules/common/metadata.ttl ./modules/common/system.ttl '
shapefiles='./modules/common/metadata-shacl.ttl ./modules/common/system.shacl.ttl'
ONTOLOGY=ammo
SHACL=ammo.shacl

VERSION=` grep -i versionInfo modules/common/metadata.ttl | sed 's/[^"]*"\([^"]*\).*/\1/'`

if [ -f "$ONTOLOGY" ]; then
    rm ${ONTOLOGY}.ttl
fi

if [ -f "$SHACL" ]; then
    rm  ${SHACL}.ttl
fi

$mergecmd merge $files -f ttl -o ./
mv merged.ttl ${ONTOLOGY}.ttl
$pylodecmd ${ONTOLOGY}.ttl -o ${ONTOLOGY}.html

$mergecmd merge $shapefiles -f ttl -o ./
mv merged.ttl ${SHACL}.ttl
# $pylodecmd $SHACL

# Copy ontology file to a specific version
if [ ! -d "./versions/${VERSION}" ]; then
    mkdir ./versions/${VERSION}
    cp -f ${ONTOLOGY}.* ${SHACL}.* ./versions/${VERSION}
else
    cp -f ${ONTOLOGY}.* ${SHACL}.* ./versions/${VERSION}
fi