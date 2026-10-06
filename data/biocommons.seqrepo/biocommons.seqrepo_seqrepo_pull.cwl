cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqrepo
label: biocommons.seqrepo_seqrepo_pull
doc: "pull incremental update from seqrepo mirror. Runs `seqrepo [global options] pull [options]`; global options must come before the subcommand, so the subcommand word is a fixed argument.\n\nTool homepage: https://github.com/biocommons/biocommons.seqrepo"
arguments:
  - position: 10
    valueFrom: pull
inputs:
  - id: root_directory
    type: Directory
    doc: seqrepo root directory (SEQREPO_ROOT_DIR); staged writable and updated
      in place
    inputBinding:
      position: 1
      prefix: --root-directory
      valueFrom: $(self.basename)
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
  - id: update_latest
    type:
      - 'null'
      - boolean
    doc: 'set latest symlink to point to this instance'
    inputBinding:
      position: 11
      prefix: --update-latest
outputs:
  - id: root
    type: Directory
    doc: Updated seqrepo root directory
    outputBinding:
      glob: $(inputs.root_directory.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.root_directory)
        writable: true
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
