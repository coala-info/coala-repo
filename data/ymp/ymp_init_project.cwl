cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - init
  - project
label: ymp_init_project
doc: |-
  Initialize a YMP project

  Tool homepage: https://ymp.readthedocs.io
inputs:
  - id: yes
    type: ['null', boolean]
    doc: 'Confirm every prompt'
    inputBinding:
      position: 1
      prefix: --yes
  - id: name
    type: ['null', string]
    doc: 'Project name'
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
  - id: project_files
    type:
      type: array
      items: [File, Directory]
    doc: Project files created in the working directory
    outputBinding:
      glob: ['*']
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
stdout: ymp_init_project.out
