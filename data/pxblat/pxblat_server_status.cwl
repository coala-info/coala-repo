cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pxblat
  - server
  - status
label: pxblat_server_status
doc: "To figure out if server is alive, on static instances get usage statics.\n\nTool homepage: https://pypi.org/project/pxblat/"
inputs:
  - id: host
    type: string
    doc: Host name or address of the server
    inputBinding:
      position: 1
  - id: port
    type: int
    doc: Port of the server
    inputBinding:
      position: 2
  - id: trans
    type:
      - 'null'
      - boolean
    doc: Translate database to protein in 6 frames.
    inputBinding:
      position: 3
      prefix: --trans
outputs:
  - id: output
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
stdout: pxblat_server_status.out
