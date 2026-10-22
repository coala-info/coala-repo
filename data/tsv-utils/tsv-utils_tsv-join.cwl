cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-join
label: tsv-utils_tsv-join
doc: "Match input lines (the data stream) against lines from a filter file, based on individual fields or the entire line.\n\nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Input TSV files (the data stream). Standard input is read if no file is given."
    inputBinding:
      position: 1
  - id: filter_file
    type: File
    doc: "File with records to use as a filter."
    inputBinding:
      position: 101
      prefix: --filter-file
  - id: key_fields
    type:
      - 'null'
      - string
    doc: "Fields to use as join key. Default: 0 (entire line)."
    inputBinding:
      position: 101
      prefix: --key-fields
  - id: data_fields
    type:
      - 'null'
      - string
    doc: "Data stream fields to use as join key, if different than --key-fields."
    inputBinding:
      position: 101
      prefix: --data-fields
  - id: append_fields
    type:
      - 'null'
      - string
    doc: "Filter file fields to append to matched data stream records."
    inputBinding:
      position: 101
      prefix: --append-fields
  - id: header
    type:
      - 'null'
      - boolean
    doc: "Treat the first line of each file as a header."
    inputBinding:
      position: 101
      prefix: --header
  - id: prefix
    type:
      - 'null'
      - string
    doc: "String to use as a prefix for --append-fields when writing a header line."
    inputBinding:
      position: 101
      prefix: --prefix
  - id: write_all
    type:
      - 'null'
      - string
    doc: "Output all data stream records. STR is the --append-fields value when writing unmatched records."
    inputBinding:
      position: 101
      prefix: --write-all
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: "Exclude matching records."
    inputBinding:
      position: 101
      prefix: --exclude
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "Field delimiter. Default: TAB. (Single byte UTF-8 characters only.)"
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: allow_duplicate_keys
    type:
      - 'null'
      - boolean
    doc: "Allow duplicate keys with different append values (last entry wins)."
    inputBinding:
      position: 101
      prefix: --allow-duplicate-keys
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
    doc: "Joined TSV data"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-join_output.tsv
