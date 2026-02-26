cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedparse_promoter
label: bedparse_promoter
doc: "Report the promoter of each transcript, defined as a fixed interval around its
  start.\n\nTool homepage: https://github.com/tleonardi/bedparse"
inputs:
  - id: bedfile
    type:
      - 'null'
      - File
    doc: Path to the BED file.
    inputBinding:
      position: 1
  - id: down
    type:
      - 'null'
      - int
    doc: Get this many nt downstream of each feature.
    inputBinding:
      position: 102
      prefix: --down
  - id: unstranded
    type:
      - 'null'
      - boolean
    doc: Do not consider strands.
    inputBinding:
      position: 102
      prefix: --unstranded
  - id: up
    type:
      - 'null'
      - int
    doc: Get this many nt upstream of each feature.
    inputBinding:
      position: 102
      prefix: --up
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse_promoter.out
