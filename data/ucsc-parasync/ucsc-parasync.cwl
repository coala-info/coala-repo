cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraSync
label: ucsc-parasync
doc: "Parallel sync of a directory from a remote host.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: host
    type: string
    doc: Remote host to sync from
    inputBinding:
      position: 1
  - id: remote_dir
    type: Directory
    doc: Remote directory path
    inputBinding:
      position: 2
  - id: local_dir
    type: Directory
    doc: Local directory path
    inputBinding:
      position: 3
  - id: dry
    type:
      - 'null'
      - boolean
    doc: Don't actually sync, just print what would be done
    inputBinding:
      position: 104
      prefix: -dry
  - id: max_connections
    type:
      - 'null'
      - int
    doc: Number of simultaneous connections
    default: 10
    inputBinding:
      position: 104
      prefix: -maxConnections
  - id: newer
    type:
      - 'null'
      - boolean
    doc: Only sync files that are newer on the remote host
    inputBinding:
      position: 104
      prefix: -newer
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print out files as they are synced
    inputBinding:
      position: 104
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parasync:482--h0b57e2e_0
stdout: ucsc-parasync.out
