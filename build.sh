#!/bin/bash

# WARNING: This is a quick hack that depends on the verison of python PDM installed
pdmdir=`pdm info |grep Packages | cut -d: -f2`
cmd="pdm run python ${pdmdir}/lib/rdfx/rdfx_cli.py"
files='./modules/common/metadata.ttl ./modules/common/system.ttl '
shapefiles='./modules/common/metadata-shacl.ttl ./modules/common/system.shacl.ttl'
ONTOLOGY=ammo.ttl
SHACL=ammo.shacl.ttl

VERSION=` grep -i versionInfo modules/common/metadata.ttl | sed 's/[^"]*"\([^"]*\).*/\1/'`

if [ -f "$ONTOLOGY" ]; then
    rm $ONTOLOGY
fi

$cmd merge $files -f ttl -o ./
mv merged.ttl $ONTOLOGY

$cmd merge $shapefiles -f ttl -o ./
mv merged.ttl $SHACL

# Copy ontology file to a specific version
if [ ! -d "./versions/${VERSION}" ]; then
    mkdir ./verisons/${VERSION}
    cp -f $ONTOLOGY $SHACL ./versions/$VERSION
else
    cp -f $ONTOLOGY $SHACL ./versions/$VERSION
fi