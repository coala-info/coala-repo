cwlVersion: v1.2
class: CommandLineTool
baseCommand: pirs-profiles_error_matrix_calculator
label: pirs-profiles_error_matrix_calculator
doc: "A tool for calculating error matrices for pirs-profiles. (Note: The provided
  help text contains only system execution logs and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/galaxy001/pirs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pirs-profiles:v2.0.2dfsg-8-deb_cv1
stdout: pirs-profiles_error_matrix_calculator.out
