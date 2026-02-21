cwlVersion: v1.2
class: CommandLineTool
baseCommand: fxtract
label: fxtract
doc: "The provided text contains container runtime error messages and does not include
  the help documentation for fxtract. As a result, no arguments or descriptions could
  be extracted.\n\nTool homepage: https://github.com/ctSkennerton/fxtract"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fxtract:2.4--hc29b5fc_3
stdout: fxtract.out
