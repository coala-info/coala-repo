cwlVersion: v1.2
class: CommandLineTool
baseCommand: tabulate
label: tabulate
doc: "Pretty-print tabular data.\n\nTool homepage: https://github.com/astanin/python-tabulate"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: a filename of the file with tabular data; if "-" or missing, read data 
      from stdin.
    inputBinding:
      position: 1
  - id: float_format
    type:
      - 'null'
      - string
    doc: 'floating point number format (default: g)'
    inputBinding:
      position: 102
      prefix: --float
  - id: format
    type:
      - 'null'
      - string
    doc: 'set output table format; supported formats: plain, simple, grid, fancy_grid,
      pipe, orgtbl, rst, mediawiki, html, latex, latex_booktabs, tsv (default: simple)'
    inputBinding:
      position: 102
      prefix: --format
  - id: header
    type:
      - 'null'
      - boolean
    doc: use the first row of data as a table header
    inputBinding:
      position: 102
      prefix: --header
  - id: separator
    type:
      - 'null'
      - string
    doc: 'use a custom column separator (default: whitespace)'
    inputBinding:
      position: 102
      prefix: --sep
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'print table to FILE (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tabulate:0.7.5--py36_0
