cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv_search
label: xsv_search
doc: "Filters CSV data by whether the given regex matches a row.\n\nTool homepage:
  https://github.com/BurntSushi/xsv"
inputs:
  - id: regex
    type: string
    doc: The regex to search for
    inputBinding:
      position: 1
  - id: input
    type:
      - 'null'
      - File
    doc: Input CSV file
    inputBinding:
      position: 2
  - id: delimiter
    type:
      - 'null'
      - string
    doc: The field delimiter for reading CSV data. Must be a single character.
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Case insensitive search. This is equivalent to prefixing the regex with
      '(?i)'.
    inputBinding:
      position: 103
      prefix: --ignore-case
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: Select only rows that did not match
    inputBinding:
      position: 103
      prefix: --invert-match
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: When set, the first row will not be interpreted as headers. (i.e., They
      are not searched, analyzed, sliced, etc.)
    inputBinding:
      position: 103
      prefix: --no-headers
  - id: select_columns
    type:
      - 'null'
      - string
    doc: Select the columns to search. See 'xsv select -h' for the full syntax.
    inputBinding:
      position: 103
      prefix: --select
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
