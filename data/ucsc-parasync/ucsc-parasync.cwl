cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraSync
label: ucsc-parasync
doc: "paraSync - uses paraFetch to recursively mirror url to given path\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: connections
    type: int
    doc: N, the number of connections to use
    inputBinding:
      position: 1
  - id: retries
    type: int
    doc: R, the number of retries
    inputBinding:
      position: 2
  - id: url
    type: string
    doc: URL to mirror recursively
    inputBinding:
      position: 3
  - id: out_dir
    type: string
    doc: Output directory name (a trailing slash is added)
    inputBinding:
      position: 4
      valueFrom: $(self)/
  - id: accept
    type:
      - 'null'
      - string
    doc: "Accept only files with these extensions, comma-separated, for example 'ext1,ext2'"
    inputBinding:
      position: 0
      prefix: -A=
      separate: false
  - id: newer
    type:
      - 'null'
      - boolean
    doc: Only download a file if it is newer than the version we already have.
    inputBinding:
      position: 0
      prefix: -newer
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress of download.
    inputBinding:
      position: 0
      prefix: -progress
outputs:
  - id: mirror_dir
    type: Directory
    doc: Mirrored directory
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parasync:482--h0b57e2e_0
stdout: ucsc-parasync.out
