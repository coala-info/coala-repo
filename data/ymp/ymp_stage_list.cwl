cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - stage
  - list
label: ymp_stage_list
doc: |-
  List available stages

  Tool homepage: https://ymp.readthedocs.io
inputs:
  - id: long
    type: ['null', boolean]
    doc: 'Show full stage descriptions'
    inputBinding:
      position: 1
      prefix: --long
  - id: short
    type: ['null', boolean]
    doc: 'Show only stage names'
    inputBinding:
      position: 1
      prefix: --short
  - id: code
    type: ['null', boolean]
    doc: 'Show definition file name and line number'
    inputBinding:
      position: 1
      prefix: --code
  - id: types
    type: ['null', boolean]
    doc: 'Show input/output types'
    inputBinding:
      position: 1
      prefix: --types
  - id: params
    type: ['null', boolean]
    doc: 'Show parameters'
    inputBinding:
      position: 1
      prefix: --params
  - id: stage
    type: string
    doc: 'Stage name or pattern (e.g. "*")'
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
stdout: ymp_stage_list.out
