cwlVersion: v1.2
class: CommandLineTool
baseCommand: ntm-profiler list_db
label: ntm-profiler_list_db
doc: "List available databases\n\nTool homepage: https://github.com/jodyphelan/NTM-Profiler"
inputs:
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    inputBinding:
      position: 101
      prefix: --db_dir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug logging
    inputBinding:
      position: 101
      prefix: --debug
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Storage directory
    inputBinding:
      position: 101
      prefix: --dir
  - id: logging
    type:
      - 'null'
      - string
    doc: Logging level
    inputBinding:
      position: 101
      prefix: --logging
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Don't remove temporary files after run
    inputBinding:
      position: 101
      prefix: --no_cleanup
  - id: temp
    type:
      - 'null'
      - Directory
    doc: Temp directory to process all files
    inputBinding:
      position: 101
      prefix: --temp
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntm-profiler:0.8.1--pyhdfd78af_0
stdout: ntm-profiler_list_db.out
