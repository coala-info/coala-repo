cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tb-profiler
  - load_library
label: tb-profiler_load_library
doc: "Load a library into the tb-profiler database.\n\nTool homepage: https://github.com/jodyphelan/TBProfiler"
inputs:
  - id: prefix
    type: string
    doc: Prefix to the library files
    inputBinding:
      position: 1
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Database directory
    inputBinding:
      position: 102
      prefix: --db_dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite existing database with the same name
    inputBinding:
      position: 102
      prefix: --force
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 102
      prefix: --logging
  - id: storage_directory
    type:
      - 'null'
      - Directory
    doc: Storage directory
    inputBinding:
      position: 102
      prefix: --dir
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: Temp firectory to process all files
    inputBinding:
      position: 102
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tb-profiler:6.6.6--pyhdfd78af_0
stdout: tb-profiler_load_library.out
