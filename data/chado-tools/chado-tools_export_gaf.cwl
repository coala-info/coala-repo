cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - export
  - gaf
label: chado-tools_export_gaf
doc: "export gene annotation data from the CHADO database to a GAF file\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
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
  - id: output_file
    type: string
    doc: "GAF output file"
    inputBinding:
      position: 101
      prefix: --output_file
  - id: organism
    type: string
    doc: "abbreviation/short name of the organism"
    inputBinding:
      position: 101
      prefix: --abbreviation
  - id: database_authority
    type: string
    doc: "database from which the file is created, e.g. 'UniProtKB'"
    inputBinding:
      position: 101
      prefix: --database_authority
  - id: annotation_level
    type:
      - 'null'
      - string
    doc: "level to which GO terms are related in the output file (default: same level as in the database) (choices: default, gene, transcript, protein) [default: default]"
    inputBinding:
      position: 101
      prefix: --annotation_level
  - id: include_obsolete
    type:
      - 'null'
      - boolean
    doc: "export all features, including obsoletes"
    inputBinding:
      position: 101
      prefix: --include_obsolete
outputs:
  - id: output
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
