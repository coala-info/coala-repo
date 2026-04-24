cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyani-plus list-runs
label: pyani-plus_list-runs
doc: "List the runs defined in a given pyANI-plus SQLite3 database.\n\nTool homepage:
  https://github.com/pyani-plus/pyani-plus"
inputs:
  - id: database
    type: File
    doc: Path to pyANI-plus SQLite3 database.
    inputBinding:
      position: 101
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show debugging level logging at the terminal (in addition to the log 
      file).
    inputBinding:
      position: 101
      prefix: --debug
  - id: log
    type:
      - 'null'
      - File
    doc: Where to record log(s). Use '-' for no logging.
    inputBinding:
      position: 101
      prefix: --log
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
stdout: pyani-plus_list-runs.out
