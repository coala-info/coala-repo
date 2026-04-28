cwlVersion: v1.2
class: CommandLineTool
baseCommand: csvsort
label: csvkit_csvsort
doc: Sort CSV files. Like the Unix "sort" command, but for tabular data.
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
  - id: names
    type:
      - 'null'
      - boolean
    doc: Display column names and indices from the input CSV and exit.
    inputBinding:
      position: 102
      prefix: --names
  - id: columns
    type:
      - 'null'
      - string
    doc: A comma-separated list of column indices, names or ranges to sort by, 
      e.g. "1,id,3-5". Defaults to all columns.
    inputBinding:
      position: 102
      prefix: --columns
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Sort in descending order.
    inputBinding:
      position: 102
      prefix: --reverse
  - id: ignore_case
    type:
      - 'null'
      - boolean
    doc: Perform case-independent sorting.
    inputBinding:
      position: 102
      prefix: --ignore-case
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
stdout: csvkit_csvsort.out
s:url: https://github.com/wireservice/csvkit
$namespaces:
  s: https://schema.org/
