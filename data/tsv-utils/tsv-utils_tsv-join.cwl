cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv-join
label: tsv-utils_tsv-join
doc: "Joins lines from files based on a common key. It is similar to the Unix 'join'
  tool, but works on TSV files and supports multiple fields and non-sorted input.\n
  \nTool homepage: https://github.com/eBay/tsv-utils"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input TSV files. If not specified, stdin is used.
    inputBinding:
      position: 1
  - id: append_fields
    type:
      - 'null'
      - string
    doc: Fields from the filter file to append to the input lines.
    inputBinding:
      position: 102
      prefix: --append-fields
  - id: data_fields
    type:
      - 'null'
      - string
    doc: Fields in the filter file to use as the join key (if different from --key-fields).
    inputBinding:
      position: 102
      prefix: --data-fields
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Field delimiter.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude matching lines (anti-join).
    inputBinding:
      position: 102
      prefix: --exclude
  - id: filter_file
    type: File
    doc: File containing the data to be joined (the 'filter' file).
    inputBinding:
      position: 102
      prefix: --filter-file
  - id: header
    type:
      - 'null'
      - boolean
    doc: Treat the first line of each file as a header.
    inputBinding:
      position: 102
      prefix: --header
  - id: key_fields
    type:
      - 'null'
      - string
    doc: Fields to use as the join key (comma-separated list of field indices).
    inputBinding:
      position: 102
      prefix: --key-fields
  - id: prefix
    type:
      - 'null'
      - string
    doc: String to prefix to the appended fields.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: write_all
    type:
      - 'null'
      - string
    doc: Output all lines from the input file. If no match is found in the filter
      file, the specified string is used for the appended fields.
    inputBinding:
      position: 102
      prefix: --write-all
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsv-utils:2.2.0--h9ee0642_0
stdout: tsv-utils_tsv-join.out
