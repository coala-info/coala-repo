cwlVersion: v1.2
class: CommandLineTool
baseCommand: csvsql
label: csvkit_csvsql
doc: Generate SQL statements for one or more CSV files, or execute those 
  statements directly on a database, and execute one or more SQL queries.
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: The CSV file(s) to operate on. If omitted, will accept input as piped 
      data via STDIN.
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
  - id: dialect
    type:
      - 'null'
      - string
    doc: Dialect of SQL to generate. Cannot be used with --db.
    inputBinding:
      position: 102
      prefix: --dialect
  - id: db
    type:
      - 'null'
      - string
    doc: If present, a SQLAlchemy connection string to use to directly execute 
      generated SQL on a database.
    inputBinding:
      position: 102
      prefix: --db
  - id: engine_option
    type:
      - 'null'
      - type: array
        items: string
    doc: A keyword argument to SQLAlchemy's create_engine(), as a 
      space-separated pair. This option can be specified multiple times.
    inputBinding:
      position: 102
      prefix: --engine-option
  - id: query
    type:
      - 'null'
      - type: array
        items: string
    doc: Execute one or more SQL queries delimited by --sql-delimiter, and 
      output the result of the last query as CSV. QUERY may be a filename. 
      --query may be specified multiple times.
    inputBinding:
      position: 102
      prefix: --query
  - id: insert
    type:
      - 'null'
      - boolean
    doc: Insert the data into the table. Requires --db.
    inputBinding:
      position: 102
      prefix: --insert
  - id: prefix
    type:
      - 'null'
      - string
    doc: Add an expression following the INSERT keyword, like OR IGNORE or OR 
      REPLACE.
    inputBinding:
      position: 102
      prefix: --prefix
  - id: before_insert
    type:
      - 'null'
      - string
    doc: Before the INSERT command, execute one or more SQL queries delimited by
      --sql-delimiter. Requires --insert.
    inputBinding:
      position: 102
      prefix: --before-insert
  - id: after_insert
    type:
      - 'null'
      - string
    doc: After the INSERT command, execute one or more SQL queries delimited by 
      --sql-delimiter. Requires --insert.
    inputBinding:
      position: 102
      prefix: --after-insert
  - id: sql_delimiter
    type:
      - 'null'
      - string
    doc: Delimiter separating SQL queries in --query, --before-insert, and 
      --after-insert.
    inputBinding:
      position: 102
      prefix: --sql-delimiter
  - id: tables
    type:
      - 'null'
      - string
    doc: A comma-separated list of names of tables to be created. By default, 
      the tables will be named after the filenames without extensions or 
      "stdin".
    inputBinding:
      position: 102
      prefix: --tables
  - id: no_constraints
    type:
      - 'null'
      - boolean
    doc: Generate a schema without length limits or null checks. Useful when 
      sampling big tables.
    inputBinding:
      position: 102
      prefix: --no-constraints
  - id: unique_constraint
    type:
      - 'null'
      - string
    doc: A column-separated list of names of columns to include in a UNIQUE 
      constraint.
    inputBinding:
      position: 102
      prefix: --unique-constraint
  - id: no_create
    type:
      - 'null'
      - boolean
    doc: Skip creating the table. Requires --insert.
    inputBinding:
      position: 102
      prefix: --no-create
  - id: create_if_not_exists
    type:
      - 'null'
      - boolean
    doc: Create the table if it does not exist, otherwise keep going. Requires 
      --insert.
    inputBinding:
      position: 102
      prefix: --create-if-not-exists
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Drop the table if it already exists. Requires --insert. Cannot be used 
      with --no-create.
    inputBinding:
      position: 102
      prefix: --overwrite
  - id: db_schema
    type:
      - 'null'
      - string
    doc: Optional name of database schema to create table(s) in.
    inputBinding:
      position: 102
      prefix: --db-schema
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
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Chunk size for batch insert into the table. Requires --insert.
    inputBinding:
      position: 102
      prefix: --chunk-size
  - id: min_col_len
    type:
      - 'null'
      - int
    doc: The minimum length of text columns.
    inputBinding:
      position: 102
      prefix: --min-col-len
  - id: col_len_multiplier
    type:
      - 'null'
      - float
    doc: Multiply the maximum column length by this multiplier to accomodate 
      larger values in later runs.
    inputBinding:
      position: 102
      prefix: --col-len-multiplier
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: ghcr.io/wireservice/csvkit:latest
stdout: csvkit_csvsql.out
s:url: https://github.com/wireservice/csvkit
$namespaces:
  s: https://schema.org/
