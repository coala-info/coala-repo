cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-diff
label: mummer4_show-diff
doc: "Output a list of structural differences (GAP, DUP, BRK, JMP, INV, SEQ) for each reference and query sequence of a delta file, sorted by position.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: amos_features
    type:
      - 'null'
      - boolean
    doc: Output diff information as AMOS features
    inputBinding:
      position: 10
      prefix: -f
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not show the header
    inputBinding:
      position: 10
      prefix: -H
  - id: queries
    type:
      - 'null'
      - boolean
    doc: Show diff information for queries
    inputBinding:
      position: 10
      prefix: -q
  - id: references
    type:
      - 'null'
      - boolean
    doc: Show diff information for references (default)
    inputBinding:
      position: 10
      prefix: -r
  - id: deltafile
    type: File
    doc: Delta file from nucmer or promer
    inputBinding:
      position: 201
outputs:
  - id: differences
    type: stdout
    doc: Structural differences (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_show-diff.out
