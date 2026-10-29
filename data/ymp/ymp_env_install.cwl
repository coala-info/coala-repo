cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - env
  - install
label: ymp_env_install
doc: |-
  Install conda software environments

  Tool homepage: https://ymp.readthedocs.io
inputs:
  - id: conda_prefix
    type: ['null', string]
    doc: 'Override location for conda environments'
    inputBinding:
      position: 1
      prefix: --conda-prefix
  - id: conda_env_spec
    type: ['null', string]
    doc: 'Override conda env specs settings'
    inputBinding:
      position: 1
      prefix: --conda-env-spec
  - id: dry_run
    type: ['null', boolean]
    doc: 'Only show what would be done'
    inputBinding:
      position: 1
      prefix: --dry-run
  - id: reinstall
    type: ['null', boolean]
    doc: 'Delete existing environment and reinstall'
    inputBinding:
      position: 1
      prefix: --reinstall
  - id: no_spec
    type: ['null', boolean]
    doc: 'Don''t use conda env spec even if present'
    inputBinding:
      position: 1
      prefix: --no-spec
  - id: no_archive
    type: ['null', boolean]
    doc: 'Delete existing archives before install'
    inputBinding:
      position: 1
      prefix: --no-archive
  - id: fresh
    type: ['null', boolean]
    doc: 'Create fresh install. Implies reinstall, no-spec and no-archive'
    inputBinding:
      position: 1
      prefix: --fresh
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
stdout: ymp_env_install.out
