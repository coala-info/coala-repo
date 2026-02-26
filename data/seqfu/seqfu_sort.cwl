cwlVersion: v1.2
class: CommandLineTool
baseCommand: sort
label: seqfu_sort
doc: "Sort sequences by size printing only unique sequences\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files
    inputBinding:
      position: 1
  - id: asc
    type:
      - 'null'
      - boolean
    doc: Ascending order
    inputBinding:
      position: 102
      prefix: --asc
  - id: prefix
    type:
      - 'null'
      - string
    doc: Sequence prefix
    inputBinding:
      position: 102
      prefix: --prefix
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: Remove sequence comments
    inputBinding:
      position: 102
      prefix: --strip-comments
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_sort.out
