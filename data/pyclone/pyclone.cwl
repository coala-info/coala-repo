cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyclone
label: pyclone
doc: "PyClone is a Bayesian clustering method for grouping somatic mutations into
  clonal clusters.\n\nTool homepage: https://github.com/Roth-Lab/pyclone/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyclone:0.13.1--py_0
stdout: pyclone.out
