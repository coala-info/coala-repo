cwlVersion: v1.2
class: CommandLineTool
baseCommand: emirge_emirge.py
label: emirge_emirge.py
doc: "EMIRGE (Expectation-Maximization Iterative Reconstruction of Genes from Expression)
  reconstructs full-length ribosomal RNA genes from short-read sequencing data.\n\n
  Tool homepage: https://github.com/csmiller/EMIRGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge_emirge.py.out
