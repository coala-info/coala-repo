cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - csvtk
  - csv2rst
label: csvtk_csv2rst
doc: "convert CSV to readable aligned table\n\nTool homepage: https://github.com/shenwei356/csvtk"
inputs:
  - id: comment_char
    type:
      - 'null'
      - string
    doc: lines starting with commment-character will be ignored. if your header row
      starts with '#', please assign "-C" another rare symbol, e.g. '$'
    inputBinding:
      position: 101
      prefix: --comment-char
  - id: cross
    type:
      - 'null'
      - string
    doc: charactor of cross
    inputBinding:
      position: 101
      prefix: --cross
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
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: header_separator
    type:
      - 'null'
      - string
    doc: charactor of separator between header row and data rowws
    inputBinding:
      position: 101
      prefix: --header
  - id: horizontal_border
    type:
      - 'null'
      - string
    doc: charactor of horizontal border
    inputBinding:
      position: 101
      prefix: --horizontal-border
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
    doc: ignore illegal rows. You can also use 'csvtk fix' to fix files with different
      numbers of columns in rows
    inputBinding:
      position: 101
      prefix: --ignore-illegal-row
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line), if given, they are appended
      to files from cli arguments
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
    inputBinding:
      position: 101
      prefix: --num-cpus
  - id: out_delimiter
    type:
      - 'null'
      - string
    doc: delimiting character of the output CSV file, e.g., -D $'\t' for tab
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
  - id: padding
    type:
      - 'null'
      - string
    doc: charactor of padding
    inputBinding:
      position: 101
      prefix: --padding
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information and warnings
    inputBinding:
      position: 101
      prefix: --quiet
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
  - id: vertical_border
    type:
      - 'null'
      - string
    doc: charactor of vertical border
    inputBinding:
      position: 101
      prefix: --vertical-border
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
