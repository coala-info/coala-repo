cwlVersion: v1.2
class: CommandLineTool
baseCommand: number-lines
label: tsv-utils_number-lines
doc: "Write each line of the input to standard output preceded by a line number. Simplified version of the unix nl program with header support.\n\nTool homepage: https://github.com/eBay/tsv-utils"
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
    doc: "Treat the first line of each file as a header. The first input file header is output, subsequent file headers are discarded."
    inputBinding:
      position: 101
      prefix: -H
  - id: header_string
    type:
      - 'null'
      - string
    doc: "String to use in the header row. Implies --header. Default: line"
    inputBinding:
      position: 101
      prefix: -s
  - id: start_number
    type:
      - 'null'
      - int
    doc: "Number to use for the first line. Default: 1"
    inputBinding:
      position: 101
      prefix: -n
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Character appended to line number, preceding the rest of the line. Default: TAB (Single byte UTF-8 characters only.)"
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
  - id: numbered
    type: stdout
    doc: "Numbered lines"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: number-lines_output.txt
