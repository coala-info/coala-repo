cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - init
  - demo
label: ymp_init_demo
doc: |-
  Copies YMP tutorial data into the current working directory

  Tool homepage: https://ymp.readthedocs.io
inputs:
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
  - id: demo_files
    type:
      type: array
      items: [File, Directory]
    doc: Tutorial data and ymp.yml copied into the working directory
    outputBinding:
      glob: ['*_data', ymp.yml]
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
stdout: ymp_init_demo.out
