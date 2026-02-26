cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_fmt
label: xsv_fmt
doc: "Formats CSV data with a custom delimiter or CRLF line endings.\n\nTool homepage:
  https://github.com/BurntSushi/xsv"
inputs:
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file
    inputBinding:
      position: 1
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: Use ASCII field and record separators.
    inputBinding:
      position: 102
      prefix: --ascii
  - id: crlf
    type:
      - 'null'
      - boolean
    doc: Use '\r\n' line endings in the output.
    inputBinding:
      position: 102
      prefix: --crlf
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
  - id: out_delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for writing CSV data.
    default: ','
    inputBinding:
      position: 102
      prefix: --out-delimiter
  - id: quote
    type:
      - 'null'
      - string
    doc: The quote character to use.
    default: '"'
    inputBinding:
      position: 102
      prefix: --quote
  - id: quote_always
    type:
      - 'null'
      - boolean
    doc: Put quotes around every value.
    inputBinding:
      position: 102
      prefix: --quote-always
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
