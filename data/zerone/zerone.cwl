cwlVersion: v1.2
class: CommandLineTool
baseCommand: zerone
label: zerone
doc: "zerone\n\nTool homepage: https://github.com/nanakiksc/zerone"
inputs:
  - id: input_files_mock
    type:
      type: array
      items: File
    doc: given file is a mock control
    inputBinding:
      position: 1
  - id: input_files_chip
    type:
      type: array
      items: File
    doc: given file is a ChIP-seq experiment
    inputBinding:
      position: 2
  - id: confidence
    type:
      - 'null'
      - float
    doc: "print targets only with higher confidence\n                     restricts
      intervals accordingly in list output"
    inputBinding:
      position: 103
      prefix: --confidence
  - id: list_output
    type:
      - 'null'
      - boolean
    doc: output list of targets (default table)
    inputBinding:
      position: 103
      prefix: --list-output
  - id: quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    inputBinding:
      position: 103
      prefix: --quality
  - id: window
    type:
      - 'null'
      - int
    doc: window size in bp
    inputBinding:
      position: 103
      prefix: --window
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zerone:1.0--h577a1d6_9
stdout: zerone.out
