cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - csvtk
  - join
label: csvtk_join
doc: "join files by selected fields (inner, left and outer join).\n\nTool homepage:
  https://github.com/shenwei356/csvtk"
inputs:
  - id: comment_char
    type:
      - 'null'
      - string
    doc: lines starting with commment-character will be ignored. if your header row
      starts with '#', please assign "-C" another rare symbol, e.g. '$'
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
    doc: Semicolon separated key fields of all files, if given one, we think all the
      files have the same key columns. Fields of different files should be separated
      by ";", e.g -f "1;2" or -f "A,B;C,D" or -f id
    default: '1'
    inputBinding:
      position: 101
      prefix: --fields
  - id: fuzzy_fields
    type:
      - 'null'
      - boolean
    doc: using fuzzy fields, e.g., -F -f "*name" or -F -f "id123*"
    inputBinding:
      position: 101
      prefix: --fuzzy-fields
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
    doc: ignore illegal rows. You can also use 'csvtk fix' to fix files with different
      numbers of columns in rows
    inputBinding:
      position: 101
      prefix: --ignore-illegal-row
  - id: ignore_null
    type:
      - 'null'
      - boolean
    doc: do not match NULL values
    inputBinding:
      position: 101
      prefix: --ignore-null
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line), if given, they are appended
      to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: keep_unmatched
    type:
      - 'null'
      - boolean
    doc: keep unmatched data of the first file (left join)
    inputBinding:
      position: 101
      prefix: --keep-unmatched
  - id: lazy_quotes
    type:
      - 'null'
      - boolean
    doc: if given, a quote may appear in an unquoted field and a non-doubled quote
      may appear in a quoted field
    inputBinding:
      position: 101
      prefix: --lazy-quotes
  - id: left_join
    type:
      - 'null'
      - boolean
    doc: left join, equals to -k/--keep-unmatched, exclusive with --outer-join
    inputBinding:
      position: 101
      prefix: --left-join
  - id: na
    type:
      - 'null'
      - string
    doc: content for filling NA data
    inputBinding:
      position: 101
      prefix: --na
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
  - id: only_duplicates
    type:
      - 'null'
      - boolean
    doc: add filenames as colname prefixes or add custom suffixes only for duplicated
      colnames
    inputBinding:
      position: 101
      prefix: --only-duplicates
  - id: out_delimiter
    type:
      - 'null'
      - string
    doc: delimiting character of the output CSV file, e.g., -D $'\t' for tab
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
  - id: outer_join
    type:
      - 'null'
      - boolean
    doc: outer join, exclusive with --left-join
    inputBinding:
      position: 101
      prefix: --outer-join
  - id: prefix_filename
    type:
      - 'null'
      - boolean
    doc: add each filename as a prefix to each colname. if there's no header row,
      we'll add one
    inputBinding:
      position: 101
      prefix: --prefix-filename
  - id: prefix_trim_ext
    type:
      - 'null'
      - boolean
    doc: trim extension when adding filename as colname prefix
    inputBinding:
      position: 101
      prefix: --prefix-trim-ext
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
  - id: suffix
    type:
      - 'null'
      - type: array
        items: string
    doc: add suffixes to colnames from each file
    inputBinding:
      position: 101
      prefix: --suffix
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
