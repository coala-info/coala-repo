cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - csvtk
  - summary
label: csvtk_summary
doc: "summary statistics of selected numeric or text fields (groupby group fields)\n
  \nTool homepage: https://github.com/shenwei356/csvtk"
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
  - id: decimal_width
    type:
      - 'null'
      - int
    doc: limit floats to N decimal points
    inputBinding:
      position: 101
      prefix: --decimal-width
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
  - id: fields
    type:
      - 'null'
      - type: array
        items: string
    doc: 'operations on these fields. e.g -f 1:count,1:sum or -f colA:mean. available
      operations: argmax, argmin, collapse, count, countn, countuniq, countunique,
      entropy, first, last, max, mean, median, min, prod, q1, q2, q3, rand, stdev,
      sum, uniq, unique, variance'
    inputBinding:
      position: 101
      prefix: --fields
  - id: groups
    type:
      - 'null'
      - string
    doc: group via fields. e.g -f 1,2 or -f columnA,columnB
    inputBinding:
      position: 101
      prefix: --groups
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
  - id: ignore_non_numbers
    type:
      - 'null'
      - boolean
    doc: ignore non-numeric values like "NA" or "N/A"
    inputBinding:
      position: 101
      prefix: --ignore-non-numbers
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
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: be quiet and do not show extra information and warnings
    inputBinding:
      position: 101
      prefix: --quiet
  - id: rand_seed
    type:
      - 'null'
      - int
    doc: rand seed for operation "rand"
    inputBinding:
      position: 101
      prefix: --rand-seed
  - id: separater
    type:
      - 'null'
      - string
    doc: separater for collapsed data
    inputBinding:
      position: 101
      prefix: --separater
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
