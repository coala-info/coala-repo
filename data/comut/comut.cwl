cwlVersion: v1.2
class: CommandLineTool
baseCommand: comut
label: comut
doc: "A Python package for creating comutation plots to visualize genomic alterations.\n\
  \nTool homepage: https://github.com/vanallenlab/comut"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comut:0.0.3--pyhdfd78af_0
stdout: comut.out
