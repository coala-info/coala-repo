cwlVersion: v1.2
class: CommandLineTool
baseCommand: babappalign
label: babappalign
doc: "\nTool homepage: https://github.com/sinhakrishnendu/BABAPPAlign"
inputs:
  - id: fasta
    type: File
    inputBinding:
      position: 1
  - id: device
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --device
  - id: gap_extend
    type:
      - 'null'
      - float
    inputBinding:
      position: 102
      prefix: --gap-extend
  - id: gap_open
    type:
      - 'null'
      - float
    inputBinding:
      position: 102
      prefix: --gap-open
  - id: mode
    type:
      - 'null'
      - string
    inputBinding:
      position: 102
      prefix: --mode
  - id: model
    type: string
    inputBinding:
      position: 102
      prefix: --model
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/babappalign:1.2.0--py313h9ee0642_0
stdout: babappalign.out
