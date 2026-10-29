cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ymp
  - env
  - prepare
label: ymp_env_prepare
doc: |-
  Create envs needed to build target

  Tool homepage: https://ymp.readthedocs.io
inputs:
  - id: dryrun
    type: ['null', boolean]
    doc: 'Only show what would be done'
    inputBinding:
      position: 1
      prefix: --dryrun
  - id: printshellcmds
    type: ['null', boolean]
    doc: 'Print shell commands to be executed on shell'
    inputBinding:
      position: 1
      prefix: --printshellcmds
  - id: keepgoing
    type: ['null', boolean]
    doc: 'Don''t stop after failed job'
    inputBinding:
      position: 1
      prefix: --keepgoing
  - id: lock
    type: ['null', boolean]
    doc: 'Use locking to prevent clobbering of files by parallel instances of YMP running'
    inputBinding:
      position: 1
      prefix: --lock
  - id: no_lock
    type: ['null', boolean]
    doc: 'Don''t use locking'
    inputBinding:
      position: 1
      prefix: --no-lock
  - id: rerun_incomplete
    type: ['null', boolean]
    doc: 'Re-run jobs left incomplete in last run'
    inputBinding:
      position: 1
      prefix: --rerun-incomplete
  - id: rerun_triggers
    type: ['null', string]
    doc: 'Select reasons for reruns (mtime, params, input, software-env, code)'
    inputBinding:
      position: 1
      prefix: --rerun-triggers
  - id: scheduler
    type: ['null', string]
    doc: 'ILP or greedy'
    inputBinding:
      position: 1
      prefix: --scheduler
  - id: forceall
    type: ['null', boolean]
    doc: 'Force rebuilding of all stages leading to target'
    inputBinding:
      position: 1
      prefix: --forceall
  - id: force
    type: ['null', boolean]
    doc: 'Force rebuilding of target'
    inputBinding:
      position: 1
      prefix: --force
  - id: notemp
    type: ['null', boolean]
    doc: 'Do not remove temporary files'
    inputBinding:
      position: 1
      prefix: --notemp
  - id: touch
    type: ['null', boolean]
    doc: 'Only touch files, faking update'
    inputBinding:
      position: 1
      prefix: --touch
  - id: shadow_prefix
    type: ['null', string]
    doc: 'Directory to place data for shadowed rules'
    inputBinding:
      position: 1
      prefix: --shadow-prefix
  - id: reason
    type: ['null', boolean]
    doc: 'Print reason for executing rule'
    inputBinding:
      position: 1
      prefix: --reason
  - id: nohup
    type: ['null', boolean]
    doc: 'Don''t die once the terminal goes away.'
    inputBinding:
      position: 1
      prefix: --nohup
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
  - id: target_files
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Target to build (e.g. toy.assemble_megahit.map_bbmap)'
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
stdout: ymp_env_prepare.out
