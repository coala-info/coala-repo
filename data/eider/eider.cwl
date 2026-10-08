cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - eider
label: eider
doc: "Command line tools for DuckDB: run an SQL query through a JDBC connection
  (DuckDB by default). eider prints no result rows itself: write results with 
  COPY ... TO 'file' (or TO '/dev/stdout').\n\nTool homepage:
  https://github.com/heuermh/eider"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data files the SQL query reads (for example CSV, TSV or Parquet files
      named in read_csv or read_parquet); they are staged in the working
      directory under their own names
  - id: output_file
    type:
      - 'null'
      - string
    doc: Name of the file the query writes with COPY ... TO; collected as output
      (not passed to eider)
  - id: parameters
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --parameters
    doc: Query template parameters, in KEY=VALUE format. Specify multiple times
      if necessary.
    inputBinding:
      position: 101
  - id: preserve_whitespace
    type:
      - 'null'
      - boolean
    doc: Preserve whitespace in SQL query.
    inputBinding:
      position: 101
      prefix: --preserve-whitespace
  - id: query
    type:
      - 'null'
      - string
    doc: Inline SQL query, if any.
    inputBinding:
      position: 101
      prefix: --query
  - id: query_path
    type:
      - 'null'
      - File
    doc: SQL query input path, default stdin.
    inputBinding:
      position: 101
      prefix: --query-path
  - id: skip_history
    type:
      - 'null'
      - boolean
    doc: Skip writing query to history file.
    inputBinding:
      position: 101
      prefix: --skip-history
  - id: url
    type:
      - 'null'
      - string
    doc: JDBC connection URL, defaults to "jdbc:duckdb:".
    inputBinding:
      position: 101
      prefix: --url
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show additional logging messages.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (query results when the query copies them to 
      /dev/stdout)
  - id: result_file
    type:
      - 'null'
      - File
    doc: File written by the query (output_file)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eider:0.3--hdfd78af_0
stdout: eider.out
