cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqrepo
label: biocommons.seqrepo_seqrepo_export_aliases
doc: "export aliases. Runs `seqrepo [global options] export-aliases [options]`; global options must come before the subcommand, so the subcommand word is a fixed argument.\n\nTool homepage: https://github.com/biocommons/biocommons.seqrepo"
arguments:
  - position: 10
    valueFrom: export-aliases
inputs:
  - id: root_directory
    type: Directory
    doc: seqrepo root directory (SEQREPO_ROOT_DIR)
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
    doc: 'instance name'
    inputBinding:
      position: 11
      prefix: --instance-name
  - id: namespace
    type:
      - 'null'
      - string
    doc: 'namespace name (e.g., refseq, NCBI, Ensembl, LRG)'
    inputBinding:
      position: 11
      prefix: --namespace
outputs:
  - id: output
    type: stdout
    doc: 'Exported aliases'
stdout: seqrepo_aliases.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
