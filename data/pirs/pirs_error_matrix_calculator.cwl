cwlVersion: v1.2
class: CommandLineTool
baseCommand: pirs_error_matrix_calculator
label: pirs_error_matrix_calculator
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a failure to extract a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/galaxy001/pirs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pirs:2.0.2--pl5.22.0_1
stdout: pirs_error_matrix_calculator.out
