cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - place
label: mykatlas_place
doc: "Place a sample on a prebuilt tree\n\nTool homepage: http://github.com/phelimb/atlas"
inputs:
  - id: sample
    type: string
    doc: "sample id"
    inputBinding:
      position: 2
  - id: db_name
    type:
      - 'null'
      - string
    doc: "db_name"
    inputBinding:
      position: 1
      prefix: "--db_name"
  - id: force
    type:
      - 'null'
      - boolean
    doc: "force"
    inputBinding:
      position: 1
      prefix: "--force"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "do not output warnings to stderr"
    inputBinding:
      position: 1
      prefix: "--quiet"
  - id: tree
    type:
      - 'null'
      - File
    doc: "tree"
    inputBinding:
      position: 1
      prefix: "--tree"
  - id: searchable_samples
    type:
      - 'null'
      - File
    doc: "list of samples (file)"
    inputBinding:
      position: 1
      prefix: "--searchable_samples"
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: "do not use the cache"
    inputBinding:
      position: 1
      prefix: "--no-cache"
outputs:
  - id: stdout
    type: stdout
    doc: Placement result
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykatlas:0.6.1--py39h6a678da_6
stdout: mykatlas_place.out
