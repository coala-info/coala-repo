cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-uniq
label: tsv-utils_tsv-uniq
doc: "Filter out duplicate lines using fields as a key. Also assigns equivalence class ids and occurrence numbers.\n\nTool homepage: https://github.com/eBay/tsv-utils"
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
    doc: "Fields to use as the key. Default: 0 (entire line)."
    inputBinding:
      position: 101
      prefix: -f
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: "Ignore case when comparing keys."
    inputBinding:
      position: 101
      prefix: -i
  - id: repeated
    type:
      - 'null'
      - boolean
    doc: "Output only lines that are repeated (based on the key)."
    inputBinding:
      position: 101
      prefix: -r
  - id: at_least
    type:
      - 'null'
      - int
    doc: "Output only lines that are repeated INT times (based on the key). Zero and one are ignored."
    inputBinding:
      position: 101
      prefix: -a
  - id: max
    type:
      - 'null'
      - int
    doc: "Max number of each unique key to output (zero is ignored)."
    inputBinding:
      position: 101
      prefix: -m
  - id: equiv
    type:
      - 'null'
      - boolean
    doc: "Output equivalence class IDs rather than uniq'ing entries."
    inputBinding:
      position: 101
      prefix: -e
  - id: equiv_header
    type:
      - 'null'
      - string
    doc: "Use STR as the equiv-id field header (when using -H --equiv). Default: 'equiv_id'."
    inputBinding:
      position: 101
      prefix: --equiv-header
  - id: equiv_start
    type:
      - 'null'
      - int
    doc: "Use INT as the first equiv-id. Default: 1."
    inputBinding:
      position: 101
      prefix: --equiv-start
  - id: number
    type:
      - 'null'
      - boolean
    doc: "Output equivalence class occurrence counts rather than uniq'ing entries."
    inputBinding:
      position: 101
      prefix: -z
  - id: number_header
    type:
      - 'null'
      - string
    doc: "Use STR as the --number field header (when using -H --number). Default: 'equiv_line'."
    inputBinding:
      position: 101
      prefix: --number-header
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Field delimiter. Default: TAB. (Single byte UTF-8 characters only.)"
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
    doc: "Unique lines"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-uniq_output.tsv
