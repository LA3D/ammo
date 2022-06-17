#!/bin/bash

# WARNING: This is a quick hack that depends on the verison of python PDM installed
# Uses linkchecker (https://github.com/wummel/linkchecker) installed in pdm to check
# links againsts a docker container running apache2 on localhost:8000
# To use: Run docker-compose up -d and then run this script
cmd="pdm run linkchecker"

ONTOLOGY=ammo
SHACL=ammo.shacl

# Check root for human readable documentation
$cmd http://localhost:8000/ammo/

# Check root for shapes
$cmd http://localhost:8000/ammo/shapes/shacl

# IRI Pattern for versionIRI https://w3id.org/ammo/ont/release/0.0.1

# Check for ontology by file
$cmd http://localhost:8000/ammo/ont/0.0.1