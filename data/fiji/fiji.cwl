cwlVersion: v1.2
class: CommandLineTool
baseCommand: fiji
label: fiji
doc: "Fiji is an image processing package based on ImageJ.\n\nTool homepage: http://fiji.sc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiji:20250206--h9ee0642_1
stdout: fiji.out
