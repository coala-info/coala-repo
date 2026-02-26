cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPairs
label: ucsc-pslpairs
doc: "Combine psl files for paired-end reads.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_in_1
    type: File
    doc: First input PSL file.
    inputBinding:
      position: 1
  - id: psl_in_2
    type: File
    doc: Second input PSL file.
    inputBinding:
      position: 2
  - id: dots
    type:
      - 'null'
      - int
    doc: Output a dot every N pairs.
    inputBinding:
      position: 103
      prefix: -dots
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum gap between pairs.
    default: 500000
    inputBinding:
      position: 103
      prefix: -maxGap
  - id: min_gap
    type:
      - 'null'
      - int
    doc: Minimum gap between pairs.
    default: 0
    inputBinding:
      position: 103
      prefix: -minGap
  - id: near
    type:
      - 'null'
      - boolean
    doc: Only output pairs that are near each other.
    inputBinding:
      position: 103
      prefix: -near
outputs:
  - id: psl_out
    type: File
    doc: Output PSL file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpairs:482--h0b57e2e_0
