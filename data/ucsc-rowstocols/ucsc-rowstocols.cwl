cwlVersion: v1.2
class: CommandLineTool
baseCommand: rowsToCols
label: ucsc-rowstocols
doc: "Convert rows to columns (transpose a file).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: Input file to be transposed.
    inputBinding:
      position: 1
  - id: field_separator
    type:
      - 'null'
      - string
    doc: Use specified character as field separator.
    inputBinding:
      position: 102
      prefix: -fs
  - id: var_col
    type:
      - 'null'
      - boolean
    doc: Allow variable number of columns.
    inputBinding:
      position: 102
      prefix: -varCol
outputs:
  - id: output
    type: File
    doc: Output file where transposed data is written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-rowstocols:482--h0b57e2e_0
