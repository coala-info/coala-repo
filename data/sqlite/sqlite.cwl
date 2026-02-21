cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqlite3
label: sqlite
doc: "A command-line interface for SQLite databases that allows users to manually
  enter and execute SQL statements against an SQLite database.\n\nTool homepage: https://github.com/sqlitebrowser/sqlitebrowser"
inputs:
  - id: filename
    type:
      - 'null'
      - File
    doc: The name of the SQLite database file to open.
    inputBinding:
      position: 1
  - id: sql_command
    type:
      - 'null'
      - string
    doc: SQL command to execute against the database.
    inputBinding:
      position: 2
  - id: column
    type:
      - 'null'
      - boolean
    doc: Set output mode to 'column'.
    inputBinding:
      position: 103
      prefix: -column
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Set output mode to 'csv'.
    inputBinding:
      position: 103
      prefix: -csv
  - id: echo
    type:
      - 'null'
      - boolean
    doc: Print commands before execution.
    inputBinding:
      position: 103
      prefix: -echo
  - id: header
    type:
      - 'null'
      - boolean
    doc: Turn headers on or off.
    inputBinding:
      position: 103
      prefix: -header
  - id: html
    type:
      - 'null'
      - boolean
    doc: Set output mode to 'html'.
    inputBinding:
      position: 103
      prefix: -html
  - id: init_file
    type:
      - 'null'
      - File
    doc: Read and execute commands from the specified file.
    inputBinding:
      position: 103
      prefix: --init
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sqlite:3.33.0
stdout: sqlite.out
