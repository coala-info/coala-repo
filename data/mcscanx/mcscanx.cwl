cwlVersion: v1.2
class: CommandLineTool
baseCommand: MCScanX
label: mcscanx
doc: "MCScanX is a toolkit for evolutionary analysis of gene synteny and collinearity.\n
  \nTool homepage: https://github.com/wyp1125/MCScanX"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcscanx:1.0.0--h9948957_0
stdout: mcscanx.out
