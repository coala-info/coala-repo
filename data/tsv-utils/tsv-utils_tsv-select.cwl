cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-select
label: tsv-utils_tsv-select
doc: "Write selected fields to standard output in the order listed. Similar to unix cut, with the ability to reorder fields.\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input files. Standard input is read if no file is given."
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Treat the first line of each file as a header."
    inputBinding:
      position: 101
      prefix: -H
  - id: fields
    type:
      - 'null'
      - string
    doc: "Fields to retain. Fields are output in the order listed."
    inputBinding:
      position: 101
      prefix: -f
  - id: exclude
    type:
      - 'null'
      - string
    doc: "Fields to exclude."
    inputBinding:
      position: 101
      prefix: -e
  - id: rest
    type:
      - 'null'
      - string
    doc: "Output location for fields not included in --fields: first or last."
    inputBinding:
      position: 101
      prefix: -r
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Character to use as field delimiter. Default: TAB. (Single byte UTF-8 characters only.)"
    inputBinding:
      position: 101
      prefix: -d
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: "Immediately output every line."
    inputBinding:
      position: 101
      prefix: --line-buffered
outputs:
  - id: tsv
    type: stdout
    doc: "Selected fields"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-select_output.tsv
