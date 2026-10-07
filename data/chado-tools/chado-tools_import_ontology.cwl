cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - import
  - ontology
label: chado-tools_import_ontology
doc: "import an ontology into the CHADO database\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose mode"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: config
    type:
      - 'null'
      - File
    doc: "YAML file containing connection details"
    inputBinding:
      position: 101
      prefix: --config
  - id: use_password
    type:
      - 'null'
      - boolean
    doc: "connect with password (default: no password)"
    inputBinding:
      position: 101
      prefix: --use_password
  - id: dbname
    type: string
    doc: "name of the database"
    inputBinding:
      position: 1
  - id: input_file
    type:
      - 'null'
      - File
    doc: "file containing CV terms"
    inputBinding:
      position: 101
      prefix: --input_file
  - id: input_url
    type:
      - 'null'
      - string
    doc: "URL to a file containing CV terms"
    inputBinding:
      position: 101
      prefix: --input_url
  - id: database_authority
    type: string
    doc: "database authority of the terms in the file, e.g. 'GO'"
    inputBinding:
      position: 101
      prefix: --database_authority
  - id: format
    type:
      - 'null'
      - string
    doc: "format of the file (default: obo) (choices: obo, owl) [default: obo]"
    inputBinding:
      position: 101
      prefix: --format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
stdout: chado-tools_import_ontology.out
