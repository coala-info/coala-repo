cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - csvtk
  - pretty
label: csvtk_pretty
doc: "convert CSV to a readable aligned table\n\nTool homepage: https://github.com/shenwei356/csvtk"
inputs:
  - id: align_center
    type:
      - 'null'
      - type: array
        items: string
    doc: align right for selected columns (field index/range or column name)
    inputBinding:
      position: 101
      prefix: --align-center
  - id: align_right
    type:
      - 'null'
      - type: array
        items: string
    doc: align right for selected columns (field index/range or column name)
    inputBinding:
      position: 101
      prefix: --align-right
  - id: buf_rows
    type:
      - 'null'
      - int
    doc: the number of rows to determine the min and max widths (0 for all rows)
    inputBinding:
      position: 101
      prefix: --buf-rows
  - id: clip
    type:
      - 'null'
      - boolean
    doc: clip longer cell instead of wrapping
    inputBinding:
      position: 101
      prefix: --clip
  - id: clip_mark
    type:
      - 'null'
      - string
    doc: clip mark
    inputBinding:
      position: 101
      prefix: --clip-mark
  - id: comment_char
    type:
      - 'null'
      - string
    doc: lines starting with commment-character will be ignored
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
    inputBinding:
      position: 101
      prefix: --delimiter
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
  - id: max_width
    type:
      - 'null'
      - int
    doc: max width
    inputBinding:
      position: 101
      prefix: --max-width
  - id: min_width
    type:
      - 'null'
      - int
    doc: min width
    inputBinding:
      position: 101
      prefix: --min-width
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
    doc: delimiting character of the output CSV file
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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information and warnings
    inputBinding:
      position: 101
      prefix: --quiet
  - id: separator
    type:
      - 'null'
      - string
    doc: fields/columns separator
    inputBinding:
      position: 101
      prefix: --separator
  - id: show_row_number
    type:
      - 'null'
      - boolean
    doc: show row number as the first column, with header row skipped
    inputBinding:
      position: 101
      prefix: --show-row-number
  - id: style
    type:
      - 'null'
      - string
    doc: 'output syle. available vaules: default, plain, simple, 3line, grid, light,
      bold, double'
    inputBinding:
      position: 101
      prefix: --style
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: specifies that the input CSV file is delimited with tabs. Overrides "-d"
    inputBinding:
      position: 101
      prefix: --tabs
  - id: wrap_delimiter
    type:
      - 'null'
      - string
    doc: delimiter for wrapping cells
    inputBinding:
      position: 101
      prefix: --wrap-delimiter
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
