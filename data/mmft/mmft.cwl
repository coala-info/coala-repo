cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmft
label: mmft
doc: "A tool for processing or analyzing data (description not provided in help text).\n
  \nTool homepage: https://github.com/ARU-life-sciences/mmft"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmft:0.3.2--hc1c3326_0
stdout: mmft.out
