cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - import
  - gaf
label: chado-tools_import_gaf
doc: "import gene annotation data from a GAF file into the CHADO database\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
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
    type: File
    doc: "GFF3 input file"
    inputBinding:
      position: 101
      prefix: --input_file
  - id: organism
    type: string
    doc: "abbreviation/short name of the organism"
    inputBinding:
      position: 101
      prefix: --abbreviation
  - id: annotation_level
    type:
      - 'null'
      - string
    doc: "level to which GO terms are related in the database (default: same level as in the input file) (choices: default, gene, transcript, protein) [default: default]"
    inputBinding:
      position: 101
      prefix: --annotation_level
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
stdout: chado-tools_import_gaf.out
