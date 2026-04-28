cwlVersion: v1.2
class: CommandLineTool
baseCommand: in2csv
label: csvkit_in2csv
doc: Convert common, but less awesome, tabular data formats to CSV.
inputs:
  - id: file
    type: File
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
  - id: format
    type:
      - 'null'
      - string
    doc: The format of the input file. If not specified will be inferred from 
      the file type.
    inputBinding:
      position: 102
      prefix: --format
  - id: schema
    type:
      - 'null'
      - File
    doc: Specify a CSV-formatted schema file for converting fixed-width files. 
      See web documentation.
    inputBinding:
      position: 102
      prefix: --schema
  - id: key
    type:
      - 'null'
      - string
    doc: Specify a top-level key to look within for a list of objects to be 
      converted when processing JSON.
    inputBinding:
      position: 102
      prefix: --key
  - id: names
    type:
      - 'null'
      - boolean
    doc: Display sheet names from the input Excel file.
    inputBinding:
      position: 102
      prefix: --names
  - id: sheet
    type:
      - 'null'
      - string
    doc: The name of the Excel sheet to operate on.
    inputBinding:
      position: 102
      prefix: --sheet
  - id: write_sheets
    type:
      - 'null'
      - string
    doc: The names of the Excel sheets to write to files, or "-" to write all 
      sheets.
    inputBinding:
      position: 102
      prefix: --write-sheets
  - id: use_sheet_names
    type:
      - 'null'
      - boolean
    doc: Use the sheet names as file names when --write-sheets is set.
    inputBinding:
      position: 102
      prefix: --use-sheet-names
  - id: reset_dimensions
    type:
      - 'null'
      - boolean
    doc: Ignore the sheet dimensions provided by the XLSX file.
    inputBinding:
      position: 102
      prefix: --reset-dimensions
  - id: encoding_xls
    type:
      - 'null'
      - string
    doc: Specify the encoding of the input XLS file.
    inputBinding:
      position: 102
      prefix: --encoding-xls
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
      --no-leading-zeroes) when parsing CSV input.
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
stdout: csvkit_in2csv.out
s:url: https://github.com/wireservice/csvkit
$namespaces:
  s: https://schema.org/
