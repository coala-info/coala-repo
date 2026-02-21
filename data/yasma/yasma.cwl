cwlVersion: v1.2
class: CommandLineTool
baseCommand: yasma
label: yasma
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a container build log error.\n\nTool homepage: https://github.com/NateyJay/YASMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma.out
