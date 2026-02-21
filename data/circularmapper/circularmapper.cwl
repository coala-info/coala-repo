cwlVersion: v1.2
class: CommandLineTool
baseCommand: circularmapper
label: circularmapper
doc: "CircularMapper is a tool for the reconstruction of circular genomes. Note: The
  provided help text contains only system error messages and no usage information.\n
  \nTool homepage: https://github.com/apeltzer/CircularMapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circularmapper:1.93.5--h2a3209d_3
stdout: circularmapper.out
