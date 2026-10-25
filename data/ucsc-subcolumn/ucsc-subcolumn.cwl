cwlVersion: v1.2
class: CommandLineTool
baseCommand: subColumn
label: ucsc-subcolumn
doc: "Substitute one column in a tab-separated file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: column
    type: int
    doc: The column number (starting with 1)
    inputBinding:
      position: 1
  - id: in_file
    type: File
    doc: Tab-separated input file
    inputBinding:
      position: 2
  - id: sub_file
    type: File
    doc: Substitution file where the first column has old values and the second new values
    inputBinding:
      position: 3
  - id: out_name
    type: string
    doc: Name of the substituted output file
    inputBinding:
      position: 4
  - id: list
    type:
      - 'null'
      - boolean
    doc: Column is a comma-separated list. Substitute all elements in list
    inputBinding:
      position: 0
      prefix: -list
  - id: miss
    type:
      - 'null'
      - string
    doc: Print misses to this file instead of aborting
    inputBinding:
      position: 0
      prefix: -miss=
      separate: false
  - id: skip_miss
    type:
      - 'null'
      - boolean
    doc: Skip missing ids instead of outputting them
    inputBinding:
      position: 0
      prefix: -skipMiss
outputs:
  - id: out_file
    type: File
    doc: The substituted output file
    outputBinding:
      glob: $(inputs.out_name)
  - id: miss_file
    type:
      - 'null'
      - File
    doc: Misses file, written when the miss option is used
    outputBinding:
      glob: $(inputs.miss)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-subcolumn:482--h0b57e2e_0
