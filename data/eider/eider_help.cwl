cwlVersion: v1.2
class: CommandLineTool
baseCommand: eider
label: eider_help
doc: "Eider is a command-line tool for interacting with databases using SQL queries.\n\
  \nTool homepage: https://github.com/heuermh/eider"
inputs:
  - id: command
    type:
      - 'null'
      - string
    doc: Command to execute (e.g., help, generate-completion)
    inputBinding:
      position: 1
  - id: parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: Query template parameters, in KEY=VALUE format. Specify multiple times 
      if necessary.
    inputBinding:
      position: 102
      prefix: --parameters
  - id: preserve_whitespace
    type:
      - 'null'
      - boolean
    doc: Preserve whitespace in SQL query.
    inputBinding:
      position: 102
      prefix: --preserve-whitespace
  - id: query
    type:
      - 'null'
      - string
    doc: Inline SQL query, if any.
    inputBinding:
      position: 102
      prefix: --query
  - id: query_path
    type:
      - 'null'
      - File
    doc: SQL query input path
    default: stdin
    inputBinding:
      position: 102
      prefix: --query-path
  - id: skip_history
    type:
      - 'null'
      - boolean
    doc: Skip writing query to history file.
    inputBinding:
      position: 102
      prefix: --skip-history
  - id: url
    type:
      - 'null'
      - string
    doc: JDBC connection URL
    default: 'jdbc:duckdb:'
    inputBinding:
      position: 102
      prefix: --url
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show additional logging messages.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eider:0.3--hdfd78af_0
stdout: eider_help.out
