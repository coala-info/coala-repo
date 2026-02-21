cwlVersion: v1.2
class: CommandLineTool
baseCommand: orna
label: orna
doc: "ORNA (Optimized RNA-seq Assembly) is a tool for in silico read normalization
  of RNA-seq data.\n\nTool homepage: https://github.com/SchulzLab/ORNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orna:2.0--he52c88d_0
stdout: orna.out
