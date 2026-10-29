cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - env
  - remove
label: ymp_env_remove
doc: |-
  Remove conda environments

  Tool homepage: https://ymp.readthedocs.io
inputs:
  - id: envnames
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Environment names'
    inputBinding:
      position: 2
  - id: pdb
    type: ['null', boolean]
    doc: 'Drop into debugger on uncaught exception'
    inputBinding:
      position: 0
      prefix: --pdb
  - id: quiet
    type: ['null', boolean]
    doc: 'Decrease log verbosity'
    inputBinding:
      position: 0
      prefix: --quiet
  - id: verbose
    type: ['null', boolean]
    doc: 'Increase log verbosity'
    inputBinding:
      position: 0
      prefix: --verbose
  - id: log_file
    type: ['null', string]
    doc: 'Specify a log file'
    inputBinding:
      position: 0
      prefix: --log-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
stdout: ymp_env_remove.out
