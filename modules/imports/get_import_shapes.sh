#!/bin/sh

# Script to download ontology shape imports

# Make sure curl is in path
if ! [ -x "$(command -v curl)" ]; then
  echo 'Error: curl is not installed.' >&2
  exit 1
fi

# Geosparql SHACL
curl -O https://raw.githubusercontent.com/opengeospatial/ogc-geosparql/master/1.1/validator.ttl
mv validator.ttl geosparql.shacl.ttl

# SOSA SHACL
curl -O https://raw.githubusercontent.com/KnowWhereGraph/KWG-SHACL/main/shacl_sosa.ttl
mv shacl_sosa.ttl sosa.shacl.ttl

