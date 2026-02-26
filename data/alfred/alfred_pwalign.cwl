cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - pwalign
label: alfred_pwalign
doc: "Pairwise sequence alignment of two FASTA files\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: seq1_fasta
    type: File
    doc: First sequence FASTA file
    inputBinding:
      position: 1
  - id: seq2_fasta
    type: File
    doc: Second sequence FASTA file
    inputBinding:
      position: 2
  - id: ambiguous
    type:
      - 'null'
      - boolean
    doc: allow IUPAC ambiguity codes
    inputBinding:
      position: 103
      prefix: --ambiguous
  - id: endsfree1
    type:
      - 'null'
      - boolean
    doc: leading/trailing gaps free for seq1
    inputBinding:
      position: 103
      prefix: --endsfree1
  - id: endsfree2
    type:
      - 'null'
      - boolean
    doc: leading/trailing gaps free for seq2
    inputBinding:
      position: 103
      prefix: --endsfree2
  - id: format
    type:
      - 'null'
      - string
    doc: output format [v|h]
    default: h
    inputBinding:
      position: 103
      prefix: --format
  - id: gapext
    type:
      - 'null'
      - int
    doc: gap extension
    default: -1
    inputBinding:
      position: 103
      prefix: --gapext
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open
    default: -10
    inputBinding:
      position: 103
      prefix: --gapopen
  - id: local
    type:
      - 'null'
      - boolean
    doc: local alignment
    inputBinding:
      position: 103
      prefix: --local
  - id: match
    type:
      - 'null'
      - int
    doc: match
    default: 5
    inputBinding:
      position: 103
      prefix: --match
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatch
    default: -4
    inputBinding:
      position: 103
      prefix: --mismatch
outputs:
  - id: alignment
    type:
      - 'null'
      - File
    doc: vertical/horizontal alignment
    outputBinding:
      glob: $(inputs.alignment)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
