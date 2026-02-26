cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pxblat
  - server
label: pxblat_server
doc: "Make a server to quickly find where DNA occurs in genome\n\nTool homepage: https://pypi.org/project/pxblat/"
inputs:
  - id: command
    type: string
    doc: The command to execute (start, stop, status, or files)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pxblat:1.2.8--py311h93bbee8_1
stdout: pxblat_server.out
