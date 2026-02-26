cwlVersion: v1.2
class: CommandLineTool
baseCommand: nwalign3
label: nwalign3
doc: "Performs pairwise global alignment of two sequences using the Needleman-Wunsch
  algorithm.\n\nTool homepage: https://github.com/briney/nwalign3"
inputs:
  - id: seq1
    type: string
    doc: The first sequence.
    inputBinding:
      position: 1
  - id: seq2
    type: string
    doc: The second sequence.
    inputBinding:
      position: 2
  - id: gap_extend
    type:
      - 'null'
      - int
    doc: gap extend penalty (must be integer <= 0)
    inputBinding:
      position: 103
      prefix: --gap_extend
  - id: gap_open
    type:
      - 'null'
      - int
    doc: gap open penalty (must be integer <= 0)
    inputBinding:
      position: 103
      prefix: --gap_open
  - id: match
    type:
      - 'null'
      - int
    doc: match score (must be integer > 0)
    inputBinding:
      position: 103
      prefix: --match
  - id: matrix
    type:
      - 'null'
      - string
    doc: scoring matrix in ncbi/data/ format, if not specificied, match/mismatch
      are used
    inputBinding:
      position: 103
      prefix: --matrix
  - id: server
    type:
      - 'null'
      - int
    doc: if non-zero integer, a server is started
    inputBinding:
      position: 103
      prefix: --server
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nwalign3:0.1.6--py39hff726c5_0
stdout: nwalign3.out
