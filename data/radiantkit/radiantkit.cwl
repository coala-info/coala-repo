cwlVersion: v1.2
class: CommandLineTool
baseCommand: radiantkit
label: radiantkit
doc: "RadiantKit is a tool for image analysis and radial distribution. (Note: The
  provided text contains build logs and error messages rather than help text; no arguments
  could be extracted.)\n\nTool homepage: https://github.com/bicrolab/radiantkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radiantkit:0.1.0--pyhdfd78af_1
stdout: radiantkit.out
