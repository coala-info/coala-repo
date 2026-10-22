cwlVersion: v1.2
class: CommandLineTool
baseCommand: csv2tsv
label: tsv-utils_csv2tsv
doc: "Convert CSV (comma separated values) to TSV (tab separated values).\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input CSV files. Standard input is read if no file is given."
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Treat the first line of each file as a header. Only the header of the first file is output."
    inputBinding:
      position: 101
      prefix: -H
  - id: quote
    type:
      - 'null'
      - string
    doc: "Quoting character in CSV data. Default: double-quote (\")"
    inputBinding:
      position: 101
      prefix: -q
  - id: csv_delim
    type:
      - 'null'
      - string
    doc: "Field delimiter in CSV data. Default: comma (,)."
    inputBinding:
      position: 101
      prefix: -c
  - id: tsv_delim
    type:
      - 'null'
      - string
    doc: "Field delimiter in TSV data. Default: TAB"
    inputBinding:
      position: 101
      prefix: -t
  - id: tab_replacement
    type:
      - 'null'
      - string
    doc: "Replacement for TSV field delimiters (typically TABs) found in CSV input. Default: Space."
    inputBinding:
      position: 101
      prefix: -r
  - id: newline_replacement
    type:
      - 'null'
      - string
    doc: "Replacement for newlines found in CSV input. Default: Space."
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: tsv
    type: stdout
    doc: "Converted TSV data"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: csv2tsv_output.tsv
