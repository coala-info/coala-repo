cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_ml
label: biobb_ml
doc: "BioExcel Building Block for Machine Learning (Note: The provided text contains
  container build errors rather than CLI help documentation, so specific arguments
  could not be extracted).\n\nTool homepage: https://github.com/bioexcel/biobb_ml"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_ml:4.2.0--pyhdfd78af_0
stdout: biobb_ml.out
