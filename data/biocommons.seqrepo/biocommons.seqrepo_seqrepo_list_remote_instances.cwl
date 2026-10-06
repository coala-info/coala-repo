cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqrepo
label: biocommons.seqrepo_seqrepo_list_remote_instances
doc: "list remote seqrepo instances. Runs `seqrepo [global options] list-remote-instances [options]`; global options must come before the subcommand, so the subcommand word is a fixed argument.\n\nTool homepage: https://github.com/biocommons/biocommons.seqrepo"
arguments:
  - position: 10
    valueFrom: list-remote-instances
inputs:
  - id: root_directory
    type:
      - 'null'
      - Directory
    doc: 'seqrepo root directory (SEQREPO_ROOT_DIR) (default: /usr/local/share/seqrepo)'
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
outputs:
  - id: output
    type: stdout
    doc: 'List of remote instances'
stdout: seqrepo_remote_instances.txt
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
