cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_pytorch
label: biobb_pytorch
doc: "BioExcel Building Blocks wrapper for PyTorch (Note: The provided text contains
  container build logs and error messages rather than tool help text, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/bioexcel/biobb_pytorch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_pytorch:5.2.1--pyh5a0a8d1_0
stdout: biobb_pytorch.out
