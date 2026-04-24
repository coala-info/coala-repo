cwlVersion: v1.2
class: CommandLineTool
baseCommand: schema-salad-tool
label: schema-salad_schema-salad-tool
doc: "Schema Salad Tool\n\nTool homepage: https://github.com/common-workflow-language/schema_salad"
inputs:
  - id: schema
    type:
      - 'null'
      - string
    doc: Schema file
    inputBinding:
      position: 1
  - id: document
    type:
      - 'null'
      - string
    doc: Document file
    inputBinding:
      position: 2
  - id: codegen
    type:
      - 'null'
      - string
    doc: 'Generate classes in target language, currently supported: python'
    inputBinding:
      position: 103
      prefix: --codegen
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print even more logging
    inputBinding:
      position: 103
      prefix: --debug
  - id: non_strict
    type:
      - 'null'
      - boolean
    doc: Lenient validation (ignore unrecognized fields)
    inputBinding:
      position: 103
      prefix: --non-strict
  - id: print_avro
    type:
      - 'null'
      - boolean
    doc: Print Avro schema
    inputBinding:
      position: 103
      prefix: --print-avro
  - id: print_fieldrefs_dot
    type:
      - 'null'
      - boolean
    doc: Print graphviz file of field refs
    inputBinding:
      position: 103
      prefix: --print-fieldrefs-dot
  - id: print_index
    type:
      - 'null'
      - boolean
    doc: Print node index
    inputBinding:
      position: 103
      prefix: --print-index
  - id: print_inheritance_dot
    type:
      - 'null'
      - boolean
    doc: Print graphviz file of inheritance
    inputBinding:
      position: 103
      prefix: --print-inheritance-dot
  - id: print_jsonld_context
    type:
      - 'null'
      - boolean
    doc: Print JSON-LD context for schema
    inputBinding:
      position: 103
      prefix: --print-jsonld-context
  - id: print_metadata
    type:
      - 'null'
      - boolean
    doc: Print document metadata
    inputBinding:
      position: 103
      prefix: --print-metadata
  - id: print_oneline
    type:
      - 'null'
      - boolean
    doc: Print each error message in oneline
    inputBinding:
      position: 103
      prefix: --print-oneline
  - id: print_pre
    type:
      - 'null'
      - boolean
    doc: Print document after preprocessing
    inputBinding:
      position: 103
      prefix: --print-pre
  - id: print_rdf
    type:
      - 'null'
      - boolean
    doc: Print corresponding RDF graph for document
    inputBinding:
      position: 103
      prefix: --print-rdf
  - id: print_rdfs
    type:
      - 'null'
      - boolean
    doc: Print RDF schema
    inputBinding:
      position: 103
      prefix: --print-rdfs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only print warnings and errors.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: rdf_serializer
    type:
      - 'null'
      - string
    doc: Output RDF serialization format used by --print-rdf (one of turtle 
      (default), n3, nt, xml)
    inputBinding:
      position: 103
      prefix: --rdf-serializer
  - id: skip_schemas
    type:
      - 'null'
      - boolean
    doc: If specified, ignore $schemas sections.
    inputBinding:
      position: 103
      prefix: --skip-schemas
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Strict validation (unrecognized or out of place fields are error)
    inputBinding:
      position: 103
      prefix: --strict
  - id: strict_foreign_properties
    type:
      - 'null'
      - boolean
    doc: Strict checking of foreign properties
    inputBinding:
      position: 103
      prefix: --strict-foreign-properties
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Default logging
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/schema-salad:v3.0.20181206233650-2-deb-py3_cv1
stdout: schema-salad_schema-salad-tool.out
