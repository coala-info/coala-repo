cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - csvtk
  - mutate
label: csvtk_mutate
doc: "create new column from selected fields by regular expression\n\nTool homepage:
  https://github.com/shenwei356/csvtk"
inputs:
  - id: after
    type:
      - 'null'
      - string
    doc: insert the new column right after the given column name
    inputBinding:
      position: 101
      prefix: --after
  - id: at
    type:
      - 'null'
      - int
    doc: where the new column should appear, 1 for the 1st column, 0 for the last
      column
    inputBinding:
      position: 101
      prefix: --at
  - id: before
    type:
      - 'null'
      - string
    doc: insert the new column right before the given column name
    inputBinding:
      position: 101
      prefix: --before
  - id: comment_char
    type:
      - 'null'
      - string
    doc: lines starting with commment-character will be ignored
    default: '#'
    inputBinding:
      position: 101
      prefix: --comment-char
  - id: delete_header
    type:
      - 'null'
      - boolean
    doc: do not output header row
    inputBinding:
      position: 101
      prefix: --delete-header
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiting character of the input CSV file
    default: ','
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: fields
    type:
      - 'null'
      - string
    doc: select only these fields. e.g -f 1,2 or -f columnA,columnB
    default: '1'
    inputBinding:
      position: 101
      prefix: --fields
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore case
    inputBinding:
      position: 101
      prefix: --ignore-case
  - id: ignore_empty_row
    type:
      - 'null'
      - boolean
    doc: ignore empty rows
    inputBinding:
      position: 101
      prefix: --ignore-empty-row
  - id: ignore_illegal_row
    type:
      - 'null'
      - boolean
    doc: ignore illegal rows
    inputBinding:
      position: 101
      prefix: --ignore-illegal-row
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line)
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: lazy_quotes
    type:
      - 'null'
      - boolean
    doc: if given, a quote may appear in an unquoted field and a non-doubled quote
      may appear in a quoted field
    inputBinding:
      position: 101
      prefix: --lazy-quotes
  - id: na
    type:
      - 'null'
      - boolean
    doc: for unmatched data, use blank instead of original data
    inputBinding:
      position: 101
      prefix: --na
  - id: name
    type:
      - 'null'
      - string
    doc: new column name
    inputBinding:
      position: 101
      prefix: --name
  - id: no_header_row
    type:
      - 'null'
      - boolean
    doc: specifies that the input CSV file does not have header row
    inputBinding:
      position: 101
      prefix: --no-header-row
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    default: 4
    inputBinding:
      position: 101
      prefix: --num-cpus
  - id: out_delimiter
    type:
      - 'null'
      - string
    doc: delimiting character of the output CSV file
    default: ','
    inputBinding:
      position: 101
      prefix: --out-delimiter
  - id: out_tabs
    type:
      - 'null'
      - boolean
    doc: specifies that the output is delimited with tabs. Overrides "-D"
    inputBinding:
      position: 101
      prefix: --out-tabs
  - id: pattern
    type:
      - 'null'
      - string
    doc: search regular expression with capture bracket
    default: ^(.+)$
    inputBinding:
      position: 101
      prefix: --pattern
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information and warnings
    inputBinding:
      position: 101
      prefix: --quiet
  - id: remove
    type:
      - 'null'
      - boolean
    doc: remove input column
    inputBinding:
      position: 101
      prefix: --remove
  - id: show_row_number
    type:
      - 'null'
      - boolean
    doc: show row number as the first column, with header row skipped
    inputBinding:
      position: 101
      prefix: --show-row-number
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: specifies that the input CSV file is delimited with tabs. Overrides "-d"
    inputBinding:
      position: 101
      prefix: --tabs
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
