cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_input
label: xsv_input
doc: "Read CSV data with special quoting rules.\n\nTool homepage: https://github.com/BurntSushi/xsv"
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
  - id: escape
    type:
      - 'null'
      - string
    doc: The escape character to use. When not specified, quotes are escaped by 
      doubling them.
    inputBinding:
      position: 102
      prefix: --escape
  - id: quote
    type:
      - 'null'
      - string
    doc: The quote character to use.
    default: '"'
    inputBinding:
      position: 102
      prefix: --quote
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write output to <file> instead of stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
