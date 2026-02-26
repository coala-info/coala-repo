cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5_view
label: pod5_view
doc: "Write contents of some pod5 file(s) as a table to stdout or --output if given.\n\
  \nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: Input pod5 file(s) to view
    default: None
    inputBinding:
      position: 1
  - id: exclude
    type:
      - 'null'
      - string
    doc: Exclude a double-quoted comma-separated list of fields.
    default: None
    inputBinding:
      position: 102
      prefix: --exclude
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite destination files
    default: false
    inputBinding:
      position: 102
      prefix: --force-overwrite
  - id: ids
    type:
      - 'null'
      - boolean
    doc: Only write 'read_id' field
    default: false
    inputBinding:
      position: 102
      prefix: --ids
  - id: include
    type:
      - 'null'
      - string
    doc: Include a double-quoted comma-separated list of fields
    default: None
    inputBinding:
      position: 102
      prefix: --include
  - id: list_fields
    type:
      - 'null'
      - boolean
    doc: List all groups and fields available for selection and exit
    default: false
    inputBinding:
      position: 102
      prefix: --list-fields
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Omit the header line
    default: false
    inputBinding:
      position: 102
      prefix: --no-header
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
    default: false
    inputBinding:
      position: 102
      prefix: --recursive
  - id: separator
    type:
      - 'null'
      - string
    doc: Table separator character (e.g. ',')
    default: ''
    inputBinding:
      position: 102
      prefix: --separator
  - id: threads
    type:
      - 'null'
      - int
    doc: Set the number of reader workers
    default: 4
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
