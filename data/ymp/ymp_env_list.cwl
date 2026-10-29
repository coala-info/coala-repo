cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - env
  - list
label: ymp_env_list
doc: |-
  List conda environments

  Tool homepage: https://ymp.readthedocs.io
inputs:
  - id: sort
    type: ['null', string]
    doc: 'Sort by column (label, hash, address, installed)'
    inputBinding:
      position: 1
      prefix: --sort
  - id: reverse
    type: ['null', boolean]
    doc: 'Reverse sort order'
    inputBinding:
      position: 1
      prefix: --reverse
  - id: installed
    type: ['null', boolean]
    doc: 'List only installed environments'
    inputBinding:
      position: 1
      prefix: --installed
  - id: not_installed
    type: ['null', boolean]
    doc: 'List only not installed environments'
    inputBinding:
      position: 1
      prefix: --not-installed
  - id: extra
    type: ['null', string]
    doc: 'Show additional fields (all: everything)'
    inputBinding:
      position: 1
      prefix: --extra
  - id: csv
    type: ['null', boolean]
    doc: 'Output as machine readable CSV'
    inputBinding:
      position: 1
      prefix: --csv
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
stdout: ymp_env_list.out
