# Additive Manufacturing and Maintenance Operations Ontology (AMMO)

Ontology in support of additive manufacturing for maintenance operations developed as part of the America Makes Additive With Knowledge project by SimbaChain and the Notre Dame Center for Research Computing, Laboratory for Assured AI Applications Development (LA3D).

## Findable, Accessible, Interoperable, Reusable (FAIR) Data Principles

This ontology is developed using a [FAIR methodology](https://www.go-fair.org/fair-principles/) follows ["Best Practices for Implementing FAIR Vocabularies and Ontologies on the Web"](https://arxiv.org/abs/2003.13084v1), ["Ten simple rules for making a vocabulary FAIR"](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1009041), and FAIRsFAIR ["D2.5 FAIR Semantics Recommendations Second Iteration"](https://zenodo.org/record/4314321#.YW2XNtnMIeY). We have adopted the use of Permanent Identifiers for the Web [w3id](https://w3id.org) as recommended by the best practices documents.

## Expressivity

Ontology is modeled using [RDFS-Plus](http://mlwiki.org/index.php/RDFS-Plus) level of automatization with W3C [RDFS Schema](https://www.w3.org/TR/rdf-schema/) and selected W3C [OWL 2 Constructs](https://www.w3.org/TR/owl2-primer/). Additionally, to facilitate alignment and adoption using schema.org level base vocabularies as outlined in the schema.org [developer documentation](https://schema.org/docs/developers.html). This ontology is developed using [Modular Ontology Modeling Methodology](http://www.semantic-web-journal.net/content/modular-ontology-modeling-10) using [Ontology Design Patterns](http://ontologydesignpatterns.org/wiki/Main_Page) connected to form modules that build the larger ontology. Shape Constraints using [W3C Shapes Constraint Language](https://www.w3.org/TR/shacl/) are also provided for graph shape validation as discussed in the [SHACL and OWL](https://spinrdf.org/shacl-and-owl.html) document. Alignments are modeled similarly to the [RealEstateCore](https://github.com/RealEstateCore/rec) ontology that has created [modular alignments](https://github.com/RealEstateCore/rec/tree/master/ontology/alignments) that form the basis for adoption in [Azure Digital Twins](https://docs.microsoft.com/en-us/azure/digital-twins/concepts-ontologies) and cross linking to [Industry Standard Ontologies in a Knowledge Graph](https://docs.microsoft.com/en-us/azure/digital-twins/concepts-ontologies-adopt).

## Testing

Development of AMMO uses [Github Actions](https://github.com/features/actions) to perform CI/CD of the ontology. It runs a [SHACL](https://www.w3.org/TR/shacl/) test suite against sample knowledge graph fragments using [pyshacl](https://github.com/RDFLib/pySHACL) and the [sharness](https://github.com/chriscool/sharness) [Test Anything Protocol](http://testanything.org). Results can be reviewed in the [actions page](https://github.com/LA3D/ammo/actions) of the AMMO Github repository.

## Persistent Identifiers and Namespace

This ontology uses [w3id.org](https://w3id.org) persistent identifiers for namespaces. The rules for dereferencing the ontology using [content-negotiation](https://www.w3.org/TR/cooluris/#implementation)
can be found in the [doc/w3id](doc/w3id) subdirectory.

### Internal Namespaces

| Prefix         | URI                                 | Description            |
| -------------- | ----------------------------------- | ---------------------- |
| @prefix ammo   | https://w3id.org/ammo/ont/          | Ammo Core Ontology     |
| @prefix ammosh | https://w3id.org/ammo/shapes/shacl/ | Ammo Ontology Metadata |

### External Namespaces

| Prefix                     | URI                                                                   | Description                                                                                 |
| -------------------------- | --------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| @prefix prov               | http://www.w3.org/ns/prov#                                            | [W3C Provenance Ontology](https://www.w3.org/TR/prov-o)                                     |
| @prefix sio                | http://semanticscience.org/resource/                                  | [Semantic Science Integrated Ontology](https://github.com/MaastrichtU-IDS/semanticscience)  |
| @prefix sdo                | https://schema.org/                                                   | [Schema.org](https://Schema.org)                                                            |
| @prefix skos               | http://www.w3.org/2004/02/skos/core#                                  | [W3C Simple Knowledge Organization System](https://www.w3.org/TR/skos-reference/)           |
| @prefix time               | http://www.w3.org/2006/time#                                          | [W3C Owl Time](https://www.w3.org/TR/owl-time/)                                             |
| @prefix qudt               | http://qudt.org/schema/qudt/                                          | [Quantities, Units, Dimensions and Time Ontology](https://github.com/qudt/qudt-public-repo) |
| @prefix geosparql          | http://www.opengis.net/ont/geosparql                                  | [OGC Geosparql Spatial Ontology](https://www.ogc.org/standards/geosparql)                   |
| @prefix dcterms            | http://purl.org/dc/terms/                                             | Dublin Core Terms                                                                           |
| @prefix vann               | http://purl.org/vocab/vann/                                           | Vocabulary for annotating vocabulary terms                                                  |
| @prefix cpannotationschema | http://www.ontologydesignpatterns.org/schemas/cpannotationschema.owl# | ODP annotations                                                                             |
| @prefix gs1                | http://gs1.org/voc/                                                   | [GS1 Web Vocabulary](https://www.gs1.org/gs1-web-vocabulary)                                |

## Versions

The latest version of the full ontology can be found at https://w3id.org/ammo/ont/ and specific release versions can be found at https://w3id.org/ammo/ont/{version number}/.

## Contact

Please use this GitHub repository's [Issue tracker](https://github.com/LA3D/ammo/issues) to request new terms/classes or report errors or specific concerns related to the ontology.

## Acknowledgements

---

## Direct Contact

**Charles Vardeman**  
_Research Assistant Professor_  
[Center for Research Computing](https://crc.nd.edu), [University of Notre Dame](https://nd.edu)  
<cvardema@nd.edu>  
Github: [charlesvardeman](https://github.com/charlesvardeman)  
ORCID: [0000-0003-4091-6059](https://orcid.org/0000-0003-4091-6059)
