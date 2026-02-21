cwlVersion: v1.2
class: CommandLineTool
baseCommand: BASIC.py
label: basic
doc: "B-cell receptor Analysis Software for Single-cell (BASIC). A semi-de novo assembly
  method for assembling BCR and TCR genes from single-cell RNA-seq data.\n\nTool homepage:
  http://ttic.uchicago.edu/~aakhan/BASIC/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/basic:1.5.1--py_0
stdout: basic.out
