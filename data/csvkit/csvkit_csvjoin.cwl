cwlVersion: v1.2
class: CommandLineTool
baseCommand: csvjoin
label: csvkit_csvjoin
doc: Execute a SQL-like join to merge CSV files on a specified column or 
  columns.
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: The CSV files to operate on. If only one is specified, it will be 
      copied to STDOUT.
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
  - id: locale
    type:
      - 'null'
      - string
    doc: Specify the locale (en_US) of any formatted numbers.
    inputBinding:
      position: 102
      prefix: --locale
  - id: skipinitialspace
    type:
      - 'null'
      - boolean
    doc: Ignore whitespace immediately following the delimiter.
    inputBinding:
      position: 102
      prefix: --skipinitialspace
  - id: blanks
    type:
      - 'null'
      - boolean
    doc: Do not convert "", "na", "n/a", "none", "null", "." to NULL.
    inputBinding:
      position: 102
      prefix: --blanks
  - id: null_value
    type:
      - 'null'
      - type: array
        items: string
    doc: Convert this value to NULL. --null-value can be specified multiple 
      times.
    inputBinding:
      position: 102
      prefix: --null-value
  - id: date_format
    type:
      - 'null'
      - string
    doc: Specify a strptime date format string like "%m/%d/%Y".
    inputBinding:
      position: 102
      prefix: --date-format
  - id: datetime_format
    type:
      - 'null'
      - string
    doc: Specify a strptime datetime format string like "%m/%d/%Y %I:%M %p".
    inputBinding:
      position: 102
      prefix: --datetime-format
  - id: no_leading_zeroes
    type:
      - 'null'
      - boolean
    doc: Do not convert a numeric value with leading zeroes to a number.
    inputBinding:
      position: 102
      prefix: --no-leading-zeroes
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
  - id: columns
    type:
      - 'null'
      - string
    doc: The column name(s) on which to join. Should be either one name (or 
      index) or a comma-separated list with one name (or index) per file, in the
      same order in which the files were specified. If not specified, the two 
      files will be joined sequentially without matching.
    inputBinding:
      position: 102
      prefix: --columns
  - id: outer
    type:
      - 'null'
      - boolean
    doc: Perform a full outer join, rather than the default inner join.
    inputBinding:
      position: 102
      prefix: --outer
  - id: left
    type:
      - 'null'
      - boolean
    doc: Perform a left outer join, rather than the default inner join. If more 
      than two files are provided this will be executed as a sequence of left 
      outer joins, starting at the left.
    inputBinding:
      position: 102
      prefix: --left
  - id: right
    type:
      - 'null'
      - boolean
    doc: Perform a right outer join, rather than the default inner join. If more
      than two files are provided this will be executed as a sequence of right 
      outer joins, starting at the right.
    inputBinding:
      position: 102
      prefix: --right
  - id: snifflimit
    type:
      - 'null'
      - int
    doc: Limit CSV dialect sniffing to the specified number of bytes. Specify 
      "0" to disable sniffing entirely, or "-1" to sniff the entire file.
    inputBinding:
      position: 102
      prefix: --snifflimit
  - id: no_inference
    type:
      - 'null'
      - boolean
    doc: Disable type inference (and --locale, --date-format, --datetime-format,
      --no-leading-zeroes) when parsing the input.
    inputBinding:
      position: 102
      prefix: --no-inference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ghcr.io/wireservice/csvkit:latest
stdout: csvkit_csvjoin.out
s:url: https://github.com/wireservice/csvkit
$namespaces:
  s: https://schema.org/
