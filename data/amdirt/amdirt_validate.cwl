cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amdirt
  - validate
label: amdirt_validate
doc: "Run validity check of AncientMetagenomeDir datasets\n\nTool homepage: https://github.com/SPAAM-community/AMDirT"
inputs:
  - id: dataset
    type: File
    doc: path to tsv file of dataset to check
    inputBinding:
      position: 1
  - id: schema
    type: File
    doc: path to JSON schema file
    inputBinding:
      position: 2
  - id: columns
    type:
      - 'null'
      - boolean
    doc: Turn on column presence/absence checking.
    inputBinding:
      position: 103
      prefix: --columns
  - id: doi
    type:
      - 'null'
      - boolean
    doc: Turn on DOI duplicate checking.
    inputBinding:
      position: 103
      prefix: --doi
  - id: line_dup
    type:
      - 'null'
      - boolean
    doc: Turn on line duplicate line checking.
    inputBinding:
      position: 103
      prefix: --line_dup
  - id: local_json_schema
    type:
      - 'null'
      - Directory
    doc: path to folder with local JSON schemas
    inputBinding:
      position: 103
      prefix: --local_json_schema
  - id: markdown
    type:
      - 'null'
      - boolean
    doc: Output is in markdown format
    inputBinding:
      position: 103
      prefix: --markdown
  - id: multi_values
    type:
      - 'null'
      - string
    doc: Check multi-values column for duplicate values.
    inputBinding:
      position: 103
      prefix: --multi_values
  - id: online_archive
    type:
      - 'null'
      - boolean
    doc: Turn on ENA accession validation
    inputBinding:
      position: 103
      prefix: --online_archive
  - id: remote
    type:
      - 'null'
      - File
    doc: '[Optional] Path/URL to remote reference sample table for archive accession
      validation'
    inputBinding:
      position: 103
      prefix: --remote
  - id: schema_check
    type:
      - 'null'
      - boolean
    doc: Turn on schema checking.
    inputBinding:
      position: 103
      prefix: --schema_check
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amdirt:1.7.0--pyhdfd78af_0
stdout: amdirt_validate.out
