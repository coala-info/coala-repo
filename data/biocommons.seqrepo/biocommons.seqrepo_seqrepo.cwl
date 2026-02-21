cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqrepo
label: biocommons.seqrepo_seqrepo
doc: "command line interface to a local SeqRepo repository\n\nTool homepage: https://github.com/biocommons/biocommons.seqrepo"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (add-assembly-names, export, export-aliases, fetch-load,
      init, list-local-instances, list-remote-instances, load, pull, show-status,
      snapshot, start-shell, upgrade, update-digests, update-latest)
    inputBinding:
      position: 1
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Perform a trial run with no changes made
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: remote_host
    type:
      - 'null'
      - string
    doc: rsync server host
    default: dl.biocommons.org
    inputBinding:
      position: 102
      prefix: --remote-host
  - id: root_directory
    type:
      - 'null'
      - Directory
    doc: seqrepo root directory (SEQREPO_ROOT_DIR)
    default: /usr/local/share/seqrepo
    inputBinding:
      position: 102
      prefix: --root-directory
  - id: rsync_exe
    type:
      - 'null'
      - File
    doc: path to rsync executable
    default: /usr/bin/rsync
    inputBinding:
      position: 102
      prefix: --rsync-exe
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: be verbose; multiple accepted
    default: 0
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0
stdout: biocommons.seqrepo_seqrepo.out
