cwlVersion: v1.2
class: CommandLineTool
baseCommand: nedrex
label: nedrex
doc: "NeDREx (Network-based Drug Repurposing eXplorer) is a tool for network-based
  drug repurposing. Note: The provided help text contains only system error messages
  regarding container image building and does not list specific command-line arguments.\n
  \nTool homepage: https://pypi.org/project/nedrex/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nedrex:0.1.4--pyhdfd78af_0
stdout: nedrex.out
