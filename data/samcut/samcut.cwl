cwlVersion: v1.2
class: CommandLineTool
baseCommand: samcut
label: samcut
doc: "Print the standard 11 columns (qname, flag, ..., qual) with a header row\n\n\
  Tool homepage: https://github.com/gshiba/samcut"
inputs:
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: "Select only these fields. Example: `samcut n qname tlen read1 MD`. See --help
      for details.\n          If not supplied, `std` is used."
    inputBinding:
      position: 1
  - id: delim
    type:
      - 'null'
      - string
    doc: Character to use as delimiter for output
    default: \t
    inputBinding:
      position: 102
      prefix: --delim
  - id: fill
    type:
      - 'null'
      - string
    doc: String to fill missing values with (tags are optional and can be 
      missing)
    default: .
    inputBinding:
      position: 102
      prefix: --fill
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print a header row with column names
    inputBinding:
      position: 102
      prefix: --header
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samcut:0.1.1--h9948957_3
stdout: samcut.out
