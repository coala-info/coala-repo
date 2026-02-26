cwlVersion: v1.2
class: CommandLineTool
baseCommand: primalbedtools csv
label: primalbedtools_csv
doc: "Convert a BED file to CSV format.\n\nTool homepage: https://github.com/ChrisgKent/primalbedtools"
inputs:
  - id: bed
    type: File
    doc: Input BED file
    inputBinding:
      position: 1
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: Remove the header row from the CSV
    inputBinding:
      position: 102
      prefix: --no-headers
  - id: use_header_aliases
    type:
      - 'null'
      - boolean
    doc: Should header aliases be used.
    inputBinding:
      position: 102
      prefix: --use-header-aliases
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primalbedtools:1.0.0--pyhdfd78af_0
stdout: primalbedtools_csv.out
