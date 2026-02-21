cwlVersion: v1.2
class: CommandLineTool
baseCommand: csv2tsv
label: tsv-utils_csv2tsv
doc: "Convert CSV (comma separated values) to TSV (tab separated values).\n\nTool
  homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input CSV files to convert. If not provided, reads from stdin.
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter character.
    default: ','
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: escape
    type:
      - 'null'
      - string
    doc: The escape character.
    inputBinding:
      position: 102
      prefix: --escape
  - id: header_line
    type:
      - 'null'
      - boolean
    doc: The first line is a header.
    inputBinding:
      position: 102
      prefix: --header-line
  - id: quote
    type:
      - 'null'
      - string
    doc: The quote character.
    default: '"'
    inputBinding:
      position: 102
      prefix: --quote
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-utils_csv2tsv.out
