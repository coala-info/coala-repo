cwlVersion: v1.2
class: CommandLineTool
baseCommand: argopy
label: argopy
doc: "A Python library for Argo data beginners and experts.\n\nTool homepage: https://github.com/euroargodev/argopy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/argopy:0.1.15
stdout: argopy.out
