#!/bin/sh

# Script to download ontology imports

# Make sure curl is in path
if ! [ -x "$(command -v curl)" ]; then
  echo 'Error: curl is not installed.' >&2
  exit 1
fi


# W3C GeoSPARQL version 1.1 development version
curl -O https://raw.githubusercontent.com/opengeospatial/ogc-geosparql/master/1.1/geo.ttl

# W3C OWL-Time
curl -O https://raw.githubusercontent.com/w3c/sdw/gh-pages/time/rdf/time.ttl

# OWL-Time PROV Alignments
curl -O https://raw.githubusercontent.com/w3c/sdw/gh-pages/time/rdf/time-prov.ttl

# OWL-Time Temporal Aggregates
curl -O https://raw.githubusercontent.com/w3c/sdw/gh-pages/time-aggregates/rdf/time-agg.ttl

# W3C Prov-O
curl -O http://www.w3.org/ns/prov-o
mv prov-o prov-o.ttl

# SOSA
curl -O https://github.com/w3c/sdw/blob/gh-pages/ssn/integrated/sosa.ttl
curl -O https://raw.githubusercontent.com/w3c/sdw/gh-pages/ssn/rdf/sosa-prov-mapping.ttl


#QUDT
curl -O https://raw.githubusercontent.com/qudt/qudt-public-repo/master/vocab/quantitykinds/VOCAB_QUDT-QUANTITY-KINDS-ALL-v2.1.ttl
curl -O https://raw.githubusercontent.com/qudt/qudt-public-repo/master/vocab/unit/VOCAB_QUDT-UNITS-ALL-v2.1.ttl
curl -O https://github.com/qudt/qudt-public-repo/blob/master/schema/SCHEMA_QUDT-v2.1.ttl


# Semantic Science Integrated Ontology
# TODO: Only import release modules https://github.com/MaastrichtU-IDS/semanticscience/tree/master/ontology/sio/release as needed since sio is pretty large
curl -O https://raw.githubusercontent.com/MaastrichtU-IDS/semanticscience/master/ontology/sio.owl
if  [ -x "$(command -v riot)" ]; then
  riot --output=turtle sio.owl > sio.ttl
  rm sio.owl
fi

# W3C DCAT v2.0 -- Note content negotiation for turtle serialization by default returns html docs
# curl -H "Accept: text/turtle" -O http://www.w3.org/ns/dcat

# W3C DCAT v3.0
curl -O https://raw.githubusercontent.com/w3c/dxwg/gh-pages/dcat/rdf/dcat3.ttl

# TODO: W3C DCAT LDP Alignments https://github.com/w3c/dxwg/blob/gh-pages/dcat/alignments/LinkedDataPlatform

# DCAT Profiles
curl -H "Accept: text/turtle" -O http://www.w3.org/ns/dx/prof/

# Ontpub profile https://agldwg.github.io/ontpub-profile/profile.html
curl -O https://raw.githubusercontent.com/AGLDWG/ontpub-profile/main/profile.ttl


# DINGO: A KNOWLEDGE GRAPH ONTOLOGY FOR PROJECTS AND GRANTS https://dcodings.github.io/DINGO/
# curl -O https://raw.githubusercontent.com/dcodings/DINGO/master/DINGO-OWL.ttl

##
## Chain related vocabularies
##

# DID Vocabulary only available as JSON-LD
curl -H "Accept: application/ld+json" -O https://www.w3.org/ns/did/v1
mv v1 did.jsonld

# VC Vocabulary
curl -H "Accept: application/ld+json" -O https://www.w3.org/2018/credentials/v1
mv v1 vc.jsonld


# WOT Industrial Crosswalk if Needed https://w3c.github.io/wot-architecture/