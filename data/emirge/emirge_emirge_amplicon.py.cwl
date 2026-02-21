cwlVersion: v1.2
class: CommandLineTool
baseCommand: emirge_emirge_amplicon.py
label: emirge_emirge_amplicon.py
doc: "EMIRGE (Expectation-Maximization Iterative Reconstruction of Genes from Expression)
  for amplicon sequencing data. Note: The provided help text contains only system
  error messages regarding container execution and does not list available arguments.\n
  \nTool homepage: https://github.com/csmiller/EMIRGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge_emirge_amplicon.py.out
