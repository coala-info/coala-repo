cwlVersion: v1.2
class: CommandLineTool
baseCommand: python_circos
label: python_circos
doc: "The provided text contains system logs and error messages related to a container
  build failure rather than tool help text. No arguments or tool descriptions could
  be extracted.\n\nTool homepage: https://github.com/ponnhide/pyCircos"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/python:3.13
stdout: python_circos.out
