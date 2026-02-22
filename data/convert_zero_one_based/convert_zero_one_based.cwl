cwlVersion: v1.2
class: CommandLineTool
baseCommand: convert_zero_one_based
label: convert_zero_one_based
doc: "A tool to convert between zero-based and one-based coordinate systems (Note:
  The provided text contains only system error messages and no usage information).\n\
  \nTool homepage: https://github.com/griffithlab/convert_zero_one_based.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/convert_zero_one_based:0.0.1--py_0
stdout: convert_zero_one_based.out
