cwlVersion: v1.2
class: CommandLineTool
baseCommand: coolbox
label: coolbox
doc: "A tool for visualising genomic data, especially Hi-C data.\n\nTool homepage:
  https://github.com/GangCaoLab/CoolBox"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coolbox:0.4.0--pyhdfd78af_0
stdout: coolbox.out
