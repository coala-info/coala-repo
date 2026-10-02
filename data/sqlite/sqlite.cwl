cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/sqlite3
label: sqlite
doc: FILENAME is the name of an SQLite database. A new database is created if 
  the file does not previously exist.
inputs:
  - id: filename
    type: File
    doc: Name of an SQLite database. A new database is created if the file does 
      not previously exist.
    inputBinding:
      position: 1
  - id: sql
    type:
      - 'null'
      - string
    doc: SQL statement to execute
    inputBinding:
      position: 2
  - id: archive
    type:
      - 'null'
      - type: array
        items: string
    doc: run ".archive ARGS" and exit
    inputBinding:
      position: 103
      prefix: -A
  - id: append
    type:
      - 'null'
      - boolean
    doc: append the database to the end of the file
    inputBinding:
      position: 103
      prefix: -append
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: set output mode to 'ascii'
    inputBinding:
      position: 103
      prefix: -ascii
  - id: bail
    type:
      - 'null'
      - boolean
    doc: stop after hitting an error
    inputBinding:
      position: 103
      prefix: -bail
  - id: batch
    type:
      - 'null'
      - boolean
    doc: force batch I/O
    inputBinding:
      position: 103
      prefix: -batch
  - id: box
    type:
      - 'null'
      - boolean
    doc: set output mode to 'box'
    inputBinding:
      position: 103
      prefix: -box
  - id: column
    type:
      - 'null'
      - boolean
    doc: set output mode to 'column'
    inputBinding:
      position: 103
      prefix: -column
  - id: cmd
    type:
      - 'null'
      - string
    doc: run "COMMAND" before reading stdin
    inputBinding:
      position: 103
      prefix: -cmd
  - id: csv
    type:
      - 'null'
      - boolean
    doc: set output mode to 'csv'
    inputBinding:
      position: 103
      prefix: -csv
  - id: echo
    type:
      - 'null'
      - boolean
    doc: print commands before execution
    inputBinding:
      position: 103
      prefix: -echo
  - id: init
    type:
      - 'null'
      - File
    doc: read/process named file
    inputBinding:
      position: 103
      prefix: -init
  - id: header
    type:
      - 'null'
      - boolean
    doc: turn headers on
    inputBinding:
      position: 103
      prefix: -header
  - id: noheader
    type:
      - 'null'
      - boolean
    doc: turn headers off
    inputBinding:
      position: 103
      prefix: -noheader
  - id: html
    type:
      - 'null'
      - boolean
    doc: set output mode to HTML
    inputBinding:
      position: 103
      prefix: -html
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: force interactive I/O
    inputBinding:
      position: 103
      prefix: -interactive
  - id: json
    type:
      - 'null'
      - boolean
    doc: set output mode to 'json'
    inputBinding:
      position: 103
      prefix: -json
  - id: line
    type:
      - 'null'
      - boolean
    doc: set output mode to 'line'
    inputBinding:
      position: 103
      prefix: -line
  - id: list
    type:
      - 'null'
      - boolean
    doc: set output mode to 'list'
    inputBinding:
      position: 103
      prefix: -list
  - id: lookaside
    type:
      - 'null'
      - type: array
        items: int
    doc: use N entries of SZ bytes for lookaside memory
    inputBinding:
      position: 103
      prefix: -lookaside
  - id: markdown
    type:
      - 'null'
      - boolean
    doc: set output mode to 'markdown'
    inputBinding:
      position: 103
      prefix: -markdown
  - id: memtrace
    type:
      - 'null'
      - boolean
    doc: trace all memory allocations and deallocations
    inputBinding:
      position: 103
      prefix: -memtrace
  - id: mmap
    type:
      - 'null'
      - int
    doc: default mmap size set to N
    inputBinding:
      position: 103
      prefix: -mmap
  - id: newline
    type:
      - 'null'
      - string
    doc: "set output row separator. Default: '\\n'"
    inputBinding:
      position: 103
      prefix: -newline
  - id: nofollow
    type:
      - 'null'
      - boolean
    doc: refuse to open symbolic links to database files
    inputBinding:
      position: 103
      prefix: -nofollow
  - id: nullvalue
    type:
      - 'null'
      - string
    doc: set text string for NULL values. Default ''
    inputBinding:
      position: 103
      prefix: -nullvalue
  - id: pagecache
    type:
      - 'null'
      - type: array
        items: int
    doc: use N slots of SZ bytes each for page cache memory
    inputBinding:
      position: 103
      prefix: -pagecache
  - id: quote
    type:
      - 'null'
      - boolean
    doc: set output mode to 'quote'
    inputBinding:
      position: 103
      prefix: -quote
  - id: readonly
    type:
      - 'null'
      - boolean
    doc: open the database read-only
    inputBinding:
      position: 103
      prefix: -readonly
  - id: separator
    type:
      - 'null'
      - string
    doc: "set output column separator. Default: '|'"
    inputBinding:
      position: 103
      prefix: -separator
  - id: stats
    type:
      - 'null'
      - boolean
    doc: print memory stats before each finalize
    inputBinding:
      position: 103
      prefix: -stats
  - id: table
    type:
      - 'null'
      - boolean
    doc: set output mode to 'table'
    inputBinding:
      position: 103
      prefix: -table
  - id: vfs
    type:
      - 'null'
      - string
    doc: use NAME as the default VFS
    inputBinding:
      position: 103
      prefix: -vfs
  - id: zip
    type:
      - 'null'
      - boolean
    doc: open the file as a ZIP Archive
    inputBinding:
      position: 103
      prefix: -zip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sqlite:3.33.0
stdout: sqlite3.out
s:url: https://github.com/sqlitebrowser/sqlitebrowser
$namespaces:
  s: https://schema.org/
