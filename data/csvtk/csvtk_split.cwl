cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - csvtk
  - split
label: csvtk_split
doc: "split CSV/TSV into multiple files according to column values\n\nTool homepage:
  https://github.com/shenwei356/csvtk"
inputs:
  - id: buf_groups
    type:
      - 'null'
      - int
    doc: buffering N groups before writing to file
    default: 100
    inputBinding:
      position: 101
      prefix: --buf-groups
  - id: buf_rows
    type:
      - 'null'
      - int
    doc: buffering N rows for every group before writing to file
    default: 100000
    inputBinding:
      position: 101
      prefix: --buf-rows
  - id: comment_char
    type:
      - 'null'
      - string
    doc: lines starting with commment-character will be ignored.
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
    doc: comma separated key fields, column name or index. e.g. -f 1-3 or -f id,id2
      or -F -f "group*"
    default: '1'
    inputBinding:
      position: 101
      prefix: --fields
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite existing output directory (given by -o).
    inputBinding:
      position: 101
      prefix: --force
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
    doc: ignore illegal rows.
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
  - id: out_gzip
    type:
      - 'null'
      - boolean
    doc: force output gzipped file
    inputBinding:
      position: 101
      prefix: --out-gzip
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: output file prefix, the default value is the input file. use -p "" to disable
      outputting prefix
    inputBinding:
      position: 101
      prefix: --out-prefix
  - id: out_tabs
    type:
      - 'null'
      - boolean
    doc: specifies that the output is delimited with tabs. Overrides "-D"
    inputBinding:
      position: 101
      prefix: --out-tabs
  - id: prefix_as_subdir
    type:
      - 'null'
      - int
    doc: create subdirectories with prefixes of keys of length X, to avoid writing
      too many files in the output directory
    inputBinding:
      position: 101
      prefix: --prefix-as-subdir
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
outputs:
  - id: out_file
    type:
      - 'null'
      - Directory
    doc: 'out file ("-" for stdout, suffix .gz for gzipped out). Note: for split command,
      this can specify the output directory.'
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/csvtk:0.31.0--h9ee0642_0
