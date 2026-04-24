cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_headers
label: xsv_headers
doc: "Prints the fields of the first row in the CSV data.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: inputs
    type:
      - 'null'
      - type: array
        items: File
    doc: CSV input files
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: intersect
    type:
      - 'null'
      - boolean
    doc: Shows the intersection of all headers in all of the inputs given.
    inputBinding:
      position: 102
      prefix: --intersect
  - id: just_names
    type:
      - 'null'
      - boolean
    doc: Only show the header names (hide column index). This is automatically 
      enabled if more than one input is given.
    inputBinding:
      position: 102
      prefix: --just-names
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
stdout: xsv_headers.out
