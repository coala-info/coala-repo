cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-aligns
label: mummer4_show-aligns
doc: "Show all the alignments between a query and a reference sequence of a nucmer or promer delta file.\n\nTool homepage: https://mummer4.github.io/"
inputs:
  - id: sort_by_query
    type:
      - 'null'
      - boolean
    doc: Sort alignments by the query start coordinate
    inputBinding:
      position: 10
      prefix: -q
  - id: sort_by_reference
    type:
      - 'null'
      - boolean
    doc: Sort alignments by the reference start coordinate
    inputBinding:
      position: 10
      prefix: -r
  - id: screen_width
    type:
      - 'null'
      - int
    doc: Screen width (default is the terminal width)
    inputBinding:
      position: 10
      prefix: -w
  - id: colorize
    type:
      - 'null'
      - boolean
    doc: Colorize bases on output
    inputBinding:
      position: 10
      prefix: -c
  - id: matrix_type
    type:
      - 'null'
      - int
    doc: "Matrix type, 2 (BLOSUM 62) by default; 1 (BLOSUM 45) and 3 (BLOSUM 80) are other options"
    inputBinding:
      position: 10
      prefix: -x
  - id: marker_space
    type:
      - 'null'
      - int
    doc: "Space between markers, 10 by default, 0 disables (amino acid alignments only)"
    inputBinding:
      position: 10
      prefix: -m
  - id: deltafile
    type: File
    doc: Delta file from nucmer or promer
    inputBinding:
      position: 201
  - id: ref_id
    type: string
    doc: Reference sequence ID
    inputBinding:
      position: 202
  - id: qry_id
    type: string
    doc: Query sequence ID
    inputBinding:
      position: 203
outputs:
  - id: alignments
    type: stdout
    doc: Alignments (standard output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_show-aligns.out
