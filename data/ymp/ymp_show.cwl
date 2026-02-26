cwlVersion: v1.2
class: CommandLineTool
baseCommand: ymp_show
label: ymp_show
doc: "Show configuration properties\n\nTool homepage: https://ymp.readthedocs.io"
inputs:
  - id: property
    type: string
    doc: The configuration property to show
    inputBinding:
      position: 1
  - id: log_file
    type:
      - 'null'
      - string
    doc: Specify a log file
    inputBinding:
      position: 102
      prefix: --log-file
  - id: pdb
    type:
      - 'null'
      - boolean
    doc: Drop into debugger on uncaught exception
    inputBinding:
      position: 102
      prefix: --pdb
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease log verbosity
    inputBinding:
      position: 102
      prefix: --quiet
  - id: source
    type:
      - 'null'
      - boolean
    doc: Show source
    inputBinding:
      position: 102
      prefix: --source
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase log verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
stdout: ymp_show.out
