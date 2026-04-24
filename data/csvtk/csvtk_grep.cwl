cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - csvtk
  - grep
label: csvtk_grep
doc: "grep data by selected fields with patterns/regular expressions\n\nTool homepage:
  https://github.com/shenwei356/csvtk"
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
  - id: delete_header
    type:
      - 'null'
      - boolean
    doc: do not output header row
    inputBinding:
      position: 101
      prefix: --delete-header
  - id: delete_matched
    type:
      - 'null'
      - boolean
    doc: delete a pattern right after being matched, this keeps the firstly matched
      data and speedups when using regular expressions
    inputBinding:
      position: 101
      prefix: --delete-matched
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiting character of the input CSV file
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: fields
    type:
      - 'null'
      - string
    doc: comma separated key fields, column name or index. e.g. -f 1-3 or -f id,id2
      or -F -f "group*"
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
  - id: immediate_output
    type:
      - 'null'
      - boolean
    doc: print output immediately, do not use write buffer
    inputBinding:
      position: 101
      prefix: --immediate-output
  - id: infile_list
    type:
      - 'null'
      - File
    doc: file of input files list (one file per line), if given, they are appended
      to files from cli arguments
    inputBinding:
      position: 101
      prefix: --infile-list
  - id: invert
    type:
      - 'null'
      - boolean
    doc: invert match
    inputBinding:
      position: 101
      prefix: --invert
  - id: lazy_quotes
    type:
      - 'null'
      - boolean
    doc: if given, a quote may appear in an unquoted field and a non-doubled quote
      may appear in a quoted field
    inputBinding:
      position: 101
      prefix: --lazy-quotes
  - id: line_number
    type:
      - 'null'
      - boolean
    doc: print line number as the first column ("n")
    inputBinding:
      position: 101
      prefix: --line-number
  - id: no_header_row
    type:
      - 'null'
      - boolean
    doc: specifies that the input CSV file does not have header row
    inputBinding:
      position: 101
      prefix: --no-header-row
  - id: no_highlight
    type:
      - 'null'
      - boolean
    doc: no highlight
    inputBinding:
      position: 101
      prefix: --no-highlight
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
  - id: pattern
    type:
      - 'null'
      - type: array
        items: string
    doc: "query pattern (multiple values supported). Attention: use double quotation
      marks for patterns containing comma, e.g., -p '\"A{2,}\"'"
    inputBinding:
      position: 101
      prefix: --pattern
  - id: pattern_file
    type:
      - 'null'
      - File
    doc: pattern files (one pattern per line)
    inputBinding:
      position: 101
      prefix: --pattern-file
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
  - id: use_regexp
    type:
      - 'null'
      - boolean
    doc: patterns are regular expression
    inputBinding:
      position: 101
      prefix: --use-regexp
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: --verbose
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
