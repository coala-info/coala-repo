cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbindexdump
label: pbtk_pbindexdump
doc: "pbindexdump prints a human-readable view of PBI data to stdout.\n\nTool homepage:
  https://github.com/PacificBiosciences/pbbioconda"
inputs:
  - id: input_pbi
    type:
      - 'null'
      - File
    doc: Input PBI file. If not provided, stdin will be used as input.
    inputBinding:
      position: 1
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format. Valid choices: (json, cpp).'
    default: json
    inputBinding:
      position: 102
      prefix: --format
  - id: json_indent_level
    type:
      - 'null'
      - int
    doc: JSON indent level.
    default: 4
    inputBinding:
      position: 102
      prefix: --json-indent-level
  - id: json_raw
    type:
      - 'null'
      - boolean
    doc: Print fields in a layout that more closely reflects the PBI file format (per-field
      columns, not per-record objects.
    inputBinding:
      position: 102
      prefix: --json-raw
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, 0 means autodetection.
    default: 0
    inputBinding:
      position: 102
      prefix: --num-threads
  - id: zmws_only
    type:
      - 'null'
      - boolean
    doc: Print only the ZMW hole number for each record to stdout, one per line.
    inputBinding:
      position: 102
      prefix: --zmws-only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbtk:3.5.0--h9ee0642_0
stdout: pbtk_pbindexdump.out
