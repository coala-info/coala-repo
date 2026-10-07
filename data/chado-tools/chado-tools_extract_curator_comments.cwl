cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - extract
  - curator_comments
label: chado-tools_extract_curator_comments
doc: "list curator comments to genes and gene products in a CHADO database\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
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
  - id: include_header
    type:
      - 'null'
      - boolean
    doc: "include header in CSV output (default: False)"
    inputBinding:
      position: 101
      prefix: --include_header
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Character delimiting fields in CSV output (default: tab) [default: ]"
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: output_file
    type:
      - 'null'
      - string
    doc: "file into which data are exported (default: stdout)"
    inputBinding:
      position: 101
      prefix: --output_file
  - id: format
    type:
      - 'null'
      - string
    doc: "format of the file (default: csv) (choices: csv, json) [default: csv]"
    inputBinding:
      position: 101
      prefix: --format
  - id: organism
    type:
      - 'null'
      - string
    doc: "restrict to a certain organism, defined by its abbreviation/short name (default: all)"
    inputBinding:
      position: 101
      prefix: --abbreviation
  - id: public_only
    type:
      - 'null'
      - boolean
    doc: "restrict to public genomes (default: all)"
    inputBinding:
      position: 101
      prefix: --public_only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (results when no output file is given)
  - id: output
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
stdout: chado-tools_extract_curator_comments.out
