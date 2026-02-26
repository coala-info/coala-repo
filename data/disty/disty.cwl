cwlVersion: v1.2
class: CommandLineTool
baseCommand: disty
label: disty
doc: "compute a distance matrix from a core genome alignment file\n\nTool homepage:
  https://github.com/c2-d2/disty"
inputs:
  - id: alignment_fa
    type: File
    doc: core genome alignment file
    inputBinding:
      position: 1
  - id: input_format
    type:
      - 'null'
      - int
    doc: "input format\n                 0: ACGT\n                 1: 01"
    default: 0
    inputBinding:
      position: 102
      prefix: -i
  - id: n_strategy
    type:
      - 'null'
      - int
    doc: "strategy to deal with N's\n                 0: ignore pairwisely\n     \
      \            1: ignore pairwisely and normalize\n                 2: ignore
      globally\n                 3: replace by the major allele\n                \
      \ 4: replace by the closest individual (not implemented yet)"
    default: 0
    inputBinding:
      position: 102
      prefix: -s
  - id: skip_n_frequency
    type:
      - 'null'
      - float
    doc: skip columns having frequency of N > FLOAT
    default: 1.0
    inputBinding:
      position: 102
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/disty:0.1.0--1
stdout: disty.out
