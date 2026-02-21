cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_common
label: biobb_common
doc: "BioExcel Building Blocks common library (Note: The provided text contains system
  error logs rather than tool help documentation).\n\nTool homepage: https://github.com/bioexcel/biobb_common"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_common:5.2.1--pyhdfd78af_0
stdout: biobb_common.out
