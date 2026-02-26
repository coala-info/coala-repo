cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - stage
label: ymp_stage
doc: "Manipulate YMP stages\n\nTool homepage: https://ymp.readthedocs.io"
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
      - string
    doc: Specify a log file
    inputBinding:
      position: 103
      prefix: --log-file
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Drop into debugger on uncaught exception
    inputBinding:
      position: 103
      prefix: --pdb
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease log verbosity
    inputBinding:
      position: 103
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase log verbosity
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
stdout: ymp_stage.out
