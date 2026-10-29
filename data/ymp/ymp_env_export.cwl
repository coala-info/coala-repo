cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - env
  - export
label: ymp_env_export
doc: |-
  Export conda environments (YAML or TXT)

  Tool homepage: https://ymp.readthedocs.io
inputs:
  - id: dest_path
    type: ['null', string]
    doc: 'Destination file or directory. Default: print to standard output.'
    inputBinding:
      position: 1
      prefix: --dest
  - id: overwrite
    type: ['null', boolean]
    doc: 'Overwrite existing files'
    inputBinding:
      position: 1
      prefix: --overwrite
  - id: create_missing
    type: ['null', boolean]
    doc: 'Create environments not yet installed'
    inputBinding:
      position: 1
      prefix: --create-missing
  - id: skip_missing
    type: ['null', boolean]
    doc: 'Skip environments not yet installed'
    inputBinding:
      position: 1
      prefix: --skip-missing
  - id: filetype
    type: ['null', string]
    doc: 'Select export format (yml or txt). Default: yml unless FILE ends in .txt'
    inputBinding:
      position: 1
      prefix: --filetype
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
  - id: dest
    type:
      - 'null'
      - File
    doc: Exported environment file
    outputBinding:
      glob: |-
        ${ return inputs.dest_path ? inputs.dest_path : []; }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
stdout: ymp_env_export.out
