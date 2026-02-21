cwlVersion: v1.2
class: CommandLineTool
baseCommand: fiji-max_inscribed_circles
label: fiji-max_inscribed_circles
doc: "Fiji plugin for calculating maximum inscribed circles. (Note: The provided help
  text contains only container runtime error messages and no usage information.)\n
  \nTool homepage: https://imagej.net/plugins/max-inscribed-circles"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fiji:20250206--h9ee0642_1
stdout: fiji-max_inscribed_circles.out
