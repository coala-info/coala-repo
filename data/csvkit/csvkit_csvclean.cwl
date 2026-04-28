cwlVersion: v1.2
class: CommandLineTool
baseCommand: csvclean
label: csvkit_csvclean
doc: Report and fix common errors in a CSV file.
inputs:
  - id: file
    type:
      - 'null'
      - File
    doc: The CSV file to operate on. If omitted, will accept input as piped data
      via STDIN.
    inputBinding:
      position: 1
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiting character of the input CSV file.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: tabs
    type:
      - 'null'
      - boolean
    doc: Specify that the input CSV file is delimited with tabs. Overrides "-d".
    inputBinding:
      position: 102
      prefix: --tabs
  - id: quotechar
    type:
      - 'null'
      - string
    doc: Character used to quote strings in the input CSV file.
    inputBinding:
      position: 102
      prefix: --quotechar
  - id: quoting
    type:
      - 'null'
      - int
    doc: 'Quoting style used in the input CSV file: 0 quote minimal, 1 quote all,
      2 quote non-numeric, 3 quote none.'
    inputBinding:
      position: 102
      prefix: --quoting
  - id: no_doublequote
    type:
      - 'null'
      - boolean
    doc: Whether or not double quotes are doubled in the input CSV file.
    inputBinding:
      position: 102
      prefix: --no-doublequote
  - id: escapechar
    type:
      - 'null'
      - string
    doc: Character used to escape the delimiter if --quoting 3 ("quote none") is
      specified and to escape the QUOTECHAR if --no-doublequote is specified.
    inputBinding:
      position: 102
      prefix: --escapechar
  - id: maxfieldsize
    type:
      - 'null'
      - int
    doc: Maximum length of a single field in the input CSV file.
    inputBinding:
      position: 102
      prefix: --maxfieldsize
  - id: encoding
    type:
      - 'null'
      - string
    doc: Specify the encoding of the input CSV file.
    inputBinding:
      position: 102
      prefix: --encoding
  - id: skipinitialspace
    type:
      - 'null'
      - boolean
    doc: Ignore whitespace immediately following the delimiter.
    inputBinding:
      position: 102
      prefix: --skipinitialspace
  - id: no_header_row
    type:
      - 'null'
      - boolean
    doc: Specify that the input CSV file has no header row. Will create default 
      headers (a,b,c,...).
    inputBinding:
      position: 102
      prefix: --no-header-row
  - id: skip_lines
    type:
      - 'null'
      - int
    doc: Specify the number of initial lines to skip before the header row (e.g.
      comments, copyright notices, empty rows).
    inputBinding:
      position: 102
      prefix: --skip-lines
  - id: linenumbers
    type:
      - 'null'
      - boolean
    doc: Insert a column of line numbers at the front of the output. Useful when
      piping to grep or as a simple primary key.
    inputBinding:
      position: 102
      prefix: --linenumbers
  - id: add_bom
    type:
      - 'null'
      - boolean
    doc: Add the UTF-8 byte-order mark (BOM) to the output, for Excel 
      compatibility
    inputBinding:
      position: 102
      prefix: --add-bom
  - id: zero
    type:
      - 'null'
      - boolean
    doc: When interpreting or displaying column numbers, use zero-based 
      numbering instead of the default 1-based numbering.
    inputBinding:
      position: 102
      prefix: --zero
  - id: length_mismatch
    type:
      - 'null'
      - boolean
    doc: Report data rows that are shorter or longer than the header row.
    inputBinding:
      position: 102
      prefix: --length-mismatch
  - id: empty_columns
    type:
      - 'null'
      - boolean
    doc: Report empty columns as errors.
    inputBinding:
      position: 102
      prefix: --empty-columns
  - id: enable_all_checks
    type:
      - 'null'
      - boolean
    doc: Enable all error reporting.
    inputBinding:
      position: 102
      prefix: --enable-all-checks
  - id: omit_error_rows
    type:
      - 'null'
      - boolean
    doc: Omit data rows that contain errors, from standard output.
    inputBinding:
      position: 102
      prefix: --omit-error-rows
  - id: label
    type:
      - 'null'
      - string
    doc: Add a "label" column to standard error. Useful in automated workflows. 
      Use "-" to default to the input filename.
    inputBinding:
      position: 102
      prefix: --label
  - id: header_normalize_space
    type:
      - 'null'
      - boolean
    doc: Strip leading and trailing whitespace and replace sequences of 
      whitespace characters by a single space in the header.
    inputBinding:
      position: 102
      prefix: --header-normalize-space
  - id: join_short_rows
    type:
      - 'null'
      - boolean
    doc: Merges short rows into a single row.
    inputBinding:
      position: 102
      prefix: --join-short-rows
  - id: separator
    type:
      - 'null'
      - string
    doc: The string with which to join short rows. Defaults to a newline.
    inputBinding:
      position: 102
      prefix: --separator
  - id: fill_short_rows
    type:
      - 'null'
      - boolean
    doc: Fill short rows with the missing cells.
    inputBinding:
      position: 102
      prefix: --fill-short-rows
  - id: fillvalue
    type:
      - 'null'
      - string
    doc: The value with which to fill short rows. Defaults to none.
    inputBinding:
      position: 102
      prefix: --fillvalue
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ghcr.io/wireservice/csvkit:latest
stdout: csvkit_csvclean.out
s:url: https://github.com/wireservice/csvkit
$namespaces:
  s: https://schema.org/
