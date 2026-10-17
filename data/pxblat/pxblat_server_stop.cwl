cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pxblat
  - server
  - stop
label: pxblat_server_stop
doc: "To remove a server.\n\nTool homepage: https://pypi.org/project/pxblat/"
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
stdout: pxblat_server_stop.out
