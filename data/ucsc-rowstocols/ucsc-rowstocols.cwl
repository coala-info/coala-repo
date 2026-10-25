cwlVersion: v1.2
class: CommandLineTool
baseCommand: rowsToCols
label: ucsc-rowstocols
doc: "Convert rows to columns and vice versa in a text file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input
    type: File
    doc: Input text file to be transposed
    inputBinding:
      position: 1
  - id: output_name
    type: string
    doc: Name of the output file
    inputBinding:
      position: 2
  - id: var_col
    type:
      - 'null'
      - boolean
    doc: Rows may have various numbers of columns.
    inputBinding:
      position: 0
      prefix: -varCol
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Fields are separated by tab
    inputBinding:
      position: 0
      prefix: -tab
  - id: field_separator
    type:
      - 'null'
      - string
    doc: Fields are separated by the given character
    inputBinding:
      position: 0
      prefix: -fs=
      separate: false
  - id: fixed
    type:
      - 'null'
      - boolean
    doc: Fields are of fixed width with space padding
    inputBinding:
      position: 0
      prefix: -fixed
  - id: offsets
    type:
      - 'null'
      - string
    doc: Fields are of fixed width at given offsets (comma-separated list, X,Y,Z)
    inputBinding:
      position: 0
      prefix: -offsets=
      separate: false
outputs:
  - id: output
    type: File
    doc: Output file where transposed data is written
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-rowstocols:482--h0b57e2e_0
