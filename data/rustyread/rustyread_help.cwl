cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustyread
label: rustyread_help
doc: "A long read simulator based on badread idea and model\n\nTool homepage: https://github.com/natir/rustyread"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of thread use by rustyread, 0 use all avaible core, default 
      value 0
    default: 0
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - boolean
    doc: Verbosity level also control by environment variable RUSTYREAD_LOG if 
      flag is set RUSTYREAD_LOG value is ignored
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustyread:0.4.1--heebf65f_4
stdout: rustyread_help.out
