cwlVersion: v1.2
class: CommandLineTool
baseCommand: tb-profiler list_db
label: tb-profiler_list_db
doc: "List available databases\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: database_directory
    type:
      - 'null'
      - Directory
    doc: Database directory
    default: /usr/local/share/tbprofiler
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: logging_level
    type:
      - 'null'
      - string
    doc: Logging level
    default: INFO
    inputBinding:
      position: 101
      prefix: --logging
  - id: storage_directory
    type:
      - 'null'
      - Directory
    doc: Storage directory
    default: .
    inputBinding:
      position: 101
      prefix: --dir
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: Temp firectory to process all files
    default: .
    inputBinding:
      position: 101
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_list_db.out
