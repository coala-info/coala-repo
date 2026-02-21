cwlVersion: v1.2
class: CommandLineTool
baseCommand: yacht
label: yacht
doc: "YACHT (Yet Another K-mer Tool) is a tool for sketching and comparing large-scale
  genomic data.\n\nTool homepage: https://github.com/KoslickiLab/YACHT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yacht:1.3.2--py311h9948957_0
stdout: yacht.out
