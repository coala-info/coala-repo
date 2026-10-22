cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - load_library
label: tb-profiler_load_library
doc: "Load a new library (a database directory made by create_db) into the database directory\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: prefix
    type: Directory
    doc: 'Path of the library directory made by create_db'
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: 'Force overwrite existing database with the same name'
    inputBinding:
      position: 101
      prefix: --force
  - id: db_dir
    type: string
    doc: 'Database directory to load the library into (default: /usr/local/share/tbprofiler in the image, which is read-only)'
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: dir
    type:
      - 'null'
      - string
    doc: 'Storage directory (default: .)'
    inputBinding:
      position: 101
      prefix: --dir
  - id: temp
    type:
      - 'null'
      - string
    doc: 'Temp directory to process all files (default: .)'
    inputBinding:
      position: 101
      prefix: --temp
  - id: logging
    type:
      - 'null'
      - string
    doc: 'Logging level: DEBUG, INFO, WARNING, ERROR or CRITICAL (default: INFO)'
    inputBinding:
      position: 101
      prefix: --logging
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: loaded_db_dir
    type:
      - 'null'
      - Directory
    doc: 'Database directory with the loaded library'
    outputBinding:
      glob: $(inputs.db_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_load_library.out
