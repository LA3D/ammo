#!/bin/sh

set -e

JENAVERSION="4.4.0"

if [ -f "./apache-jena-${JENAVERSION}/bin/riot" ]; then
    RIOT="./apache-jena-${JENAVERSION}/bin/riot"
else
    RIOT="riot"
fi
ONTPATHS=$(cat .github/modules.txt | awk -F, '{print $2}')
SHAPEPATHS=$(cat .github/shapes.txt | awk -F, '{print $2}')

echo "Validating Ontology Modules"
for path in "$ONTPATHS"
do
  "$RIOT" --validate $path
done

echo "Validating Module Shapes"
for path in "$SHAPEPATHS"
do
  "$RIOT" --validate $path
done