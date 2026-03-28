# schema-salad CWL Generation Report

## schema-salad_schema-salad-tool

### Tool Description
Schema Salad Tool

### Metadata
- **Docker Image**: biocontainers/schema-salad:v3.0.20181206233650-2-deb-py3_cv1
- **Homepage**: https://github.com/common-workflow-language/schema_salad
- **Package**: https://anaconda.org/channels/bioconda/packages/schema-salad/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/schema-salad/overview
- **Total Downloads**: 104.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/common-workflow-language/schema_salad
- **Stars**: N/A
### Original Help Text
```text
usage: schema-salad-tool [-h] [--rdf-serializer RDF_SERIALIZER]
                         [--skip-schemas] [--strict-foreign-properties]
                         [--print-jsonld-context | --print-rdfs | --print-avro | --print-rdf | --print-pre | --print-index | --print-metadata | --print-inheritance-dot | --print-fieldrefs-dot | --codegen language | --print-oneline]
                         [--strict | --non-strict]
                         [--verbose | --quiet | --debug] [--version]
                         [schema] [document]

positional arguments:
  schema
  document

optional arguments:
  -h, --help            show this help message and exit
  --rdf-serializer RDF_SERIALIZER
                        Output RDF serialization format used by --print-rdf
                        (one of turtle (default), n3, nt, xml)
  --skip-schemas        If specified, ignore $schemas sections.
  --strict-foreign-properties
                        Strict checking of foreign properties
  --print-jsonld-context
                        Print JSON-LD context for schema
  --print-rdfs          Print RDF schema
  --print-avro          Print Avro schema
  --print-rdf           Print corresponding RDF graph for document
  --print-pre           Print document after preprocessing
  --print-index         Print node index
  --print-metadata      Print document metadata
  --print-inheritance-dot
                        Print graphviz file of inheritance
  --print-fieldrefs-dot
                        Print graphviz file of field refs
  --codegen language    Generate classes in target language, currently
                        supported: python
  --print-oneline       Print each error message in oneline
  --strict              Strict validation (unrecognized or out of place fields
                        are error)
  --non-strict          Lenient validation (ignore unrecognized fields)
  --verbose             Default logging
  --quiet               Only print warnings and errors.
  --debug               Print even more logging
  --version, -v         Print version
```


## schema-salad_schema-salad-doc

### Tool Description
Generates documentation from schema-salad schemas.

### Metadata
- **Docker Image**: biocontainers/schema-salad:v3.0.20181206233650-2-deb-py3_cv1
- **Homepage**: https://github.com/common-workflow-language/schema_salad
- **Package**: https://anaconda.org/channels/bioconda/packages/schema-salad/overview
- **Validation**: PASS

### Original Help Text
```text
usage: schema-salad-doc [-h] [--only ONLY] [--redirect REDIRECT]
                        [--brand BRAND] [--brandlink BRANDLINK]
                        [--primtype PRIMTYPE]
                        schema

positional arguments:
  schema

optional arguments:
  -h, --help            show this help message and exit
  --only ONLY
  --redirect REDIRECT
  --brand BRAND
  --brandlink BRANDLINK
  --primtype PRIMTYPE
```


## Metadata
- **Skill**: generated
