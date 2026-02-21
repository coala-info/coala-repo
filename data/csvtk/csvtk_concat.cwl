cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - csvtk
  - concat
label: csvtk_concat
doc: "concatenate CSV/TSV files by rows. Note that the second and later files are
  concatenated to the first one, so only columns match that of the first files kept.\n
  \nTool homepage: https://github.com/shenwei356/csvtk"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input CSV/TSV files
    inputBinding:
      position: 1
  - id: comment_char
    type:
      - 'null'
      - string
    doc: lines starting with commment-character will be ignored. if your header row
      starts with '#', please assign "-C" another rare symbol, e.g. '$'
    default: '#'
    inputBinding:
      position: 102
      prefix: --comment-char
  - id: delete_header
    type:
      - 'null'
      - boolean
    doc: do not output header row
    inputBinding:
      position: 102
      prefix: --delete-header
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiting character of the input CSV file
    default: ','
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: ignore case (column name)
    inputBinding:
      position: 102
      prefix: --ignore-case
  - id: ignore_empty_row
    type:
      - 'null'
      - boolean
    doc: ignore empty rows
    inputBinding:
      position: 102
      prefix: --ignore-empty-row
  - id: ignore_illegal_row
    type:
      - 'null'
      - boolean
    doc: ignore illegal rows. You can also use 'csvtk fix' to fix files with different
      numbers of columns in rows
    inputBinding:
      position: 102
      prefix: --ignore-illegal-row
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line), if given, they are appended
      to files from cli arguments
    inputBinding:
      position: 102
      prefix: --infile-list
  - id: keep_unmatched
    type:
      - 'null'
      - boolean
    doc: keep blanks even if no any data of a file matches
    inputBinding:
      position: 102
      prefix: --keep-unmatched
  - id: lazy_quotes
    type:
      - 'null'
      - boolean
    doc: if given, a quote may appear in an unquoted field and a non-doubled quote
      may appear in a quoted field
    inputBinding:
      position: 102
      prefix: --lazy-quotes
  - id: no_header_row
    type:
      - 'null'
      - boolean
    doc: specifies that the input CSV file does not have header row
    inputBinding:
      position: 102
      prefix: --no-header-row
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    default: 4
    inputBinding:
      position: 102
      prefix: --num-cpus
  - id: out_delimiter
    type:
      - 'null'
      - string
    doc: "delimiting character of the output CSV file, e.g., -D $'\t' for tab"
    default: ','
    inputBinding:
      position: 102
      prefix: --out-delimiter
  - id: out_tabs
    type:
      - 'null'
      - boolean
    doc: specifies that the output is delimited with tabs. Overrides "-D"
    inputBinding:
      position: 102
      prefix: --out-tabs
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information and warnings
    inputBinding:
      position: 102
      prefix: --quiet
  - id: show_row_number
    type:
      - 'null'
      - boolean
    doc: show row number as the first column, with header row skipped
    inputBinding:
      position: 102
      prefix: --show-row-number
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: specifies that the input CSV file is delimited with tabs. Overrides "-d"
    inputBinding:
      position: 102
      prefix: --tabs
  - id: unmatched_repl
    type:
      - 'null'
      - string
    doc: replacement for unmatched data
    inputBinding:
      position: 102
      prefix: --unmatched-repl
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
