cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqlite3
label: sqlite
doc: FILENAME is the name of an SQLite database. A new database is created if 
  the file does not previously exist.
inputs:
  - id: filename
    type: File
    doc: Name of an SQLite database. A new database is created if the file does 
      not previously exist.
    inputBinding:
      position: 10
  - id: sql
    type:
      - 'null'
      - string
    doc: SQL statement to execute
    inputBinding:
      position: 11
  - id: sql_script
    type:
      - 'null'
      - File
    doc: SQL script (and dot-commands) read from standard input
  - id: archive
    type:
      - 'null'
      - type: array
        items: string
    doc: run ".archive ARGS" and exit
    inputBinding:
      position: 1
      prefix: -A
  - id: append
    type:
      - 'null'
      - boolean
    doc: append the database to the end of the file
    inputBinding:
      position: 1
      prefix: -append
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: set output mode to 'ascii'
    inputBinding:
      position: 1
      prefix: -ascii
  - id: bail
    type:
      - 'null'
      - boolean
    doc: stop after hitting an error
    inputBinding:
      position: 1
      prefix: -bail
  - id: batch
    type:
      - 'null'
      - boolean
    doc: force batch I/O
    inputBinding:
      position: 1
      prefix: -batch
  - id: box
    type:
      - 'null'
      - boolean
    doc: set output mode to 'box'
    inputBinding:
      position: 1
      prefix: -box
  - id: column
    type:
      - 'null'
      - boolean
    doc: set output mode to 'column'
    inputBinding:
      position: 1
      prefix: -column
  - id: cmd
    type:
      - 'null'
      - string
    doc: run "COMMAND" before reading stdin
    inputBinding:
      position: 1
      prefix: -cmd
  - id: csv
    type:
      - 'null'
      - boolean
    doc: set output mode to 'csv'
    inputBinding:
      position: 1
      prefix: -csv
  - id: echo
    type:
      - 'null'
      - boolean
    doc: print commands before execution
    inputBinding:
      position: 1
      prefix: -echo
  - id: init
    type:
      - 'null'
      - File
    doc: read/process named file
    inputBinding:
      position: 1
      prefix: -init
  - id: header
    type:
      - 'null'
      - boolean
    doc: turn headers on
    inputBinding:
      position: 1
      prefix: -header
  - id: noheader
    type:
      - 'null'
      - boolean
    doc: turn headers off
    inputBinding:
      position: 1
      prefix: -noheader
  - id: html
    type:
      - 'null'
      - boolean
    doc: set output mode to HTML
    inputBinding:
      position: 1
      prefix: -html
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: force interactive I/O
    inputBinding:
      position: 1
      prefix: -interactive
  - id: json
    type:
      - 'null'
      - boolean
    doc: set output mode to 'json'
    inputBinding:
      position: 1
      prefix: -json
  - id: line
    type:
      - 'null'
      - boolean
    doc: set output mode to 'line'
    inputBinding:
      position: 1
      prefix: -line
  - id: list
    type:
      - 'null'
      - boolean
    doc: set output mode to 'list'
    inputBinding:
      position: 1
      prefix: -list
  - id: lookaside
    type:
      - 'null'
      - type: array
        items: int
    doc: use N entries of SZ bytes for lookaside memory
    inputBinding:
      position: 1
      prefix: -lookaside
  - id: markdown
    type:
      - 'null'
      - boolean
    doc: set output mode to 'markdown'
    inputBinding:
      position: 1
      prefix: -markdown
  - id: memtrace
    type:
      - 'null'
      - boolean
    doc: trace all memory allocations and deallocations
    inputBinding:
      position: 1
      prefix: -memtrace
  - id: mmap
    type:
      - 'null'
      - int
    doc: default mmap size set to N
    inputBinding:
      position: 1
      prefix: -mmap
  - id: newline
    type:
      - 'null'
      - string
    doc: "set output row separator. Default: '\\n'"
    inputBinding:
      position: 1
      prefix: -newline
  - id: nofollow
    type:
      - 'null'
      - boolean
    doc: refuse to open symbolic links to database files
    inputBinding:
      position: 1
      prefix: -nofollow
  - id: nullvalue
    type:
      - 'null'
      - string
    doc: set text string for NULL values. Default ''
    inputBinding:
      position: 1
      prefix: -nullvalue
  - id: pagecache
    type:
      - 'null'
      - type: array
        items: int
    doc: use N slots of SZ bytes each for page cache memory
    inputBinding:
      position: 1
      prefix: -pagecache
  - id: quote
    type:
      - 'null'
      - boolean
    doc: set output mode to 'quote'
    inputBinding:
      position: 1
      prefix: -quote
  - id: readonly
    type:
      - 'null'
      - boolean
    doc: open the database read-only
    inputBinding:
      position: 1
      prefix: -readonly
  - id: separator
    type:
      - 'null'
      - string
    doc: "set output column separator. Default: '|'"
    inputBinding:
      position: 1
      prefix: -separator
  - id: stats
    type:
      - 'null'
      - boolean
    doc: print memory stats before each finalize
    inputBinding:
      position: 1
      prefix: -stats
  - id: table
    type:
      - 'null'
      - boolean
    doc: set output mode to 'table'
    inputBinding:
      position: 1
      prefix: -table
  - id: vfs
    type:
      - 'null'
      - string
    doc: use NAME as the default VFS
    inputBinding:
      position: 1
      prefix: -vfs
  - id: zip
    type:
      - 'null'
      - boolean
    doc: open the file as a ZIP Archive
    inputBinding:
      position: 1
      prefix: -zip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database
    type:
      - 'null'
      - File
    doc: The database file after the statements ran
    outputBinding:
      glob: $(inputs.filename.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.filename)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sqlite:3.33.0
stdout: sqlite3.out
stdin: "$(inputs.sql_script ? inputs.sql_script.path : null)"
s:url: https://www.sqlite.org
$namespaces:
  s: https://schema.org/
