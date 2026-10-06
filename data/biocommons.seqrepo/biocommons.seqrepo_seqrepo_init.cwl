cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqrepo
label: biocommons.seqrepo_seqrepo_init
doc: "initialize seqrepo directory. Runs `seqrepo [global options] init [options]`; global options must come before the subcommand, so the subcommand word is a fixed argument.\n\nTool homepage: https://github.com/biocommons/biocommons.seqrepo"
arguments:
  - position: 10
    valueFrom: init
inputs:
  - id: root_directory
    type: string
    doc: seqrepo root directory to create (SEQREPO_ROOT_DIR)
    default: seqrepo
    inputBinding:
      position: 1
      prefix: --root-directory
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: 'Dry run (global option)'
    inputBinding:
      position: 1
      prefix: --dry-run
  - id: remote_host
    type:
      - 'null'
      - string
    doc: 'rsync server host (default: dl.biocommons.org)'
    inputBinding:
      position: 1
      prefix: --remote-host
  - id: rsync_exe
    type:
      - 'null'
      - string
    doc: 'path to rsync executable (default: /usr/bin/rsync)'
    inputBinding:
      position: 1
      prefix: --rsync-exe
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'be verbose'
    inputBinding:
      position: 1
      prefix: --verbose
  - id: instance_name
    type:
      - 'null'
      - string
    doc: 'instance name; must be writeable (i.e., not a snapshot)'
    inputBinding:
      position: 11
      prefix: --instance-name
outputs:
  - id: root
    type: Directory
    doc: seqrepo root directory
    outputBinding:
      glob: $(inputs.root_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
