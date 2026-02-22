cwlVersion: v1.2
class: CommandLineTool
baseCommand: cytotrace2
label: cytotrace2-python
doc: "CytoTRACE 2 (Cellular (and) Trajectory Reconstruction Analysis using Gene Expression)
  is a computational method for predicting cellular differentiation states from single-cell
  RNA-sequencing data.\n\nTool homepage: https://github.com/digitalcytometry/cytotrace2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cytotrace2-python:1.1.0--pyhdfd78af_0
stdout: cytotrace2-python.out
