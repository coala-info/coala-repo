cwlVersion: v1.2
class: CommandLineTool
baseCommand: moss
label: moss
doc: "The provided text contains container runtime errors and does not include the
  help documentation for the 'moss' tool. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/elkebir-group/Moss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moss:0.1.1--h84372a0_6
stdout: moss.out
