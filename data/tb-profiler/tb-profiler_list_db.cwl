cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - list_db
label: tb-profiler_list_db
doc: "List the mutation databases that are loaded\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
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
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: 'Database directory (default: bundled database in the image)'
    inputBinding:
      position: 101
      prefix: --db_dir
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_list_db.out
