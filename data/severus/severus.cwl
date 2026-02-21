cwlVersion: v1.2
class: CommandLineTool
baseCommand: severus
label: severus
doc: "Severus is a tool for detecting structural variants (SVs) from long-read sequencing
  data.\n\nTool homepage: https://github.com/KolmogorovLab/Severus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/severus:1.6--pyhdfd78af_0
stdout: severus.out
