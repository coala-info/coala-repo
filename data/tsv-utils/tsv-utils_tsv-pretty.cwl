cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-pretty
label: tsv-utils_tsv-pretty
doc: "Output TSV data in a more human readable format by lining up data into fixed-width columns.\n\nTool homepage: https://github.com/eBay/tsv-utils"
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
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: "Assume no header. Turns off automatic header detection."
    inputBinding:
      position: 101
      prefix: -x
  - id: lookahead
    type:
      - 'null'
      - int
    doc: "Lines to read to interpret data before generating output. Default: 1000"
    inputBinding:
      position: 101
      prefix: -l
  - id: repeat_header
    type:
      - 'null'
      - int
    doc: "Lines to print before repeating the header. Default: No repeating header"
    inputBinding:
      position: 101
      prefix: -r
  - id: underline_header
    type:
      - 'null'
      - boolean
    doc: "Underline the header."
    inputBinding:
      position: 101
      prefix: -u
  - id: format_floats
    type:
      - 'null'
      - boolean
    doc: "Format floats for better readability. Default: No"
    inputBinding:
      position: 101
      prefix: -f
  - id: precision
    type:
      - 'null'
      - int
    doc: "Max floating point precision. Implies --format-floats. Default: 9"
    inputBinding:
      position: 101
      prefix: -p
  - id: replace_empty
    type:
      - 'null'
      - boolean
    doc: "Replace empty fields with '--'."
    inputBinding:
      position: 101
      prefix: -e
  - id: empty_replacement
    type:
      - 'null'
      - string
    doc: "Replace empty fields with a string."
    inputBinding:
      position: 101
      prefix: -E
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Field delimiter. Default: TAB. (Single byte UTF-8 characters only.)"
    inputBinding:
      position: 101
      prefix: -d
  - id: space_between_fields
    type:
      - 'null'
      - int
    doc: "Spaces between each field (Default: 2)"
    inputBinding:
      position: 101
      prefix: -s
  - id: max_text_width
    type:
      - 'null'
      - int
    doc: "Max reserved field width for variable width text fields. Default: 40"
    inputBinding:
      position: 101
      prefix: -m
  - id: auto_preamble
    type:
      - 'null'
      - boolean
    doc: "Treat initial lines in a file as a preamble if the line contains no field delimiters."
    inputBinding:
      position: 101
      prefix: -a
  - id: preamble
    type:
      - 'null'
      - int
    doc: "Treat the first NUM lines as a preamble and output them unchanged."
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: pretty
    type: stdout
    doc: "Aligned table"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-pretty_output.txt
