cwlVersion: v1.2
class: CommandLineTool
baseCommand: macaron_MACARON_validate.sh
label: macaron_MACARON_validate.sh
doc: "Validation script for MACARON. (Note: The provided help text contains system
  error messages and does not list specific arguments.)\n\nTool homepage: https://github.com/waqasuddinkhan/MACARON-GenMed-LabEx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macaron:1.0--pyh864c0ab_1
stdout: macaron_MACARON_validate.sh.out
