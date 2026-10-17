cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyani-plus
  - list-runs
label: pyani-plus_list-runs
doc: "List the runs defined in a given pyANI-plus SQLite3 database.\n\nTool homepage: https://github.com/pyani-plus/pyani-plus"
inputs:
  - id: database
    type: File
    doc: "Path to pyANI-plus SQLite3 database (a writable copy is used)."
    inputBinding:
      position: 1
      prefix: --database
      valueFrom: $(self.basename)
  - id: log
    type:
      - 'null'
      - string
    doc: "Where to record log(s). Use '-' for no logging."
    inputBinding:
      position: 10
      prefix: --log
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Show debugging level logging at the terminal (in addition to the log file)."
    inputBinding:
      position: 10
      prefix: --debug
outputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file (written when log is set)
    outputBinding:
      glob: $(inputs.log)
  - id: stdout_text
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.database)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyani-plus:1.0.0--pyhdfd78af_0
stdout: pyani-plus_list-runs.out
