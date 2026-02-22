cwlVersion: v1.2
class: CommandLineTool
baseCommand: bufet
label: bufet
doc: "The provided text does not contain help information for the tool 'bufet'. It
  consists of system error messages related to container execution and disk space
  issues.\n\nTool homepage: https://github.com/diwis/BUFET/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bufet:1.0--py35h470a237_0
stdout: bufet.out
