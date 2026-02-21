cwlVersion: v1.2
class: CommandLineTool
baseCommand: emirge
label: emirge
doc: "EMIRGE (Expectation-Maximization Iterative Reconstruction of Genes from Expression)
  reconstructs full-length ribosomal genes from short-read sequencing data.\n\nTool
  homepage: https://github.com/csmiller/EMIRGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge.out
