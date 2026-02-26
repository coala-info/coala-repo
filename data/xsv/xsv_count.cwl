cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_count
label: xsv_count
doc: "Prints a count of the number of records in the CSV data.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    default: ','
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will not be included in the count.
    inputBinding:
      position: 102
      prefix: --no-headers
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
stdout: xsv_count.out
