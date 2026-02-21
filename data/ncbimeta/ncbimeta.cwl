cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbimeta
label: ncbimeta
doc: "The provided text is an error log indicating a failure to run the tool due to
  storage issues ('no space left on device'). Based on the tool's standard documentation,
  ncbimeta is a tool for retrieving and organizing NCBI metadata into a local database.\n
  \nTool homepage: https://github.com/ktmeaton/NCBImeta"
inputs:
  - id: db
    type:
      - 'null'
      - File
    doc: Name of the output SQLite database
    inputBinding:
      position: 101
      prefix: --db
  - id: flat
    type:
      - 'null'
      - boolean
    doc: Output files in a flat directory structure
    inputBinding:
      position: 101
      prefix: --flat
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of existing database
    inputBinding:
      position: 101
      prefix: --force
  - id: queries
    type:
      - 'null'
      - File
    doc: File containing search queries
    inputBinding:
      position: 101
      prefix: --queries
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress output messages
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Directory for output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbimeta:0.8.3--pyhdfd78af_0
