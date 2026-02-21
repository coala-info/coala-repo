cwlVersion: v1.2
class: CommandLineTool
baseCommand: olga
label: olga
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages and a fatal error regarding disk
  space.\n\nTool homepage: https://github.com/zsethna/OLGA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/olga:1.3.0--pyh7e72e81_0
stdout: olga.out
