cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_dbcan
label: dbcan_run_dbcan
doc: "use dbCAN tools to annotate and analyze CAZymes and CGCs.\n\nTool homepage:
  http://bcb.unl.edu/dbCAN2/"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
  - id: log_file
    type:
      - 'null'
      - File
    doc: Write logs to file in addition to console
    inputBinding:
      position: 103
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Set logging level (default: WARNING, only shows warnings and errors)'
    inputBinding:
      position: 103
      prefix: --log-level
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging (equivalent to --log-level DEBUG)
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dbcan:5.2.8--pyhdfd78af_0
stdout: dbcan_run_dbcan.out
