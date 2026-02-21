cwlVersion: v1.2
class: CommandLineTool
baseCommand: nedbit-features-calculator
label: nedbit-features-calculator_nedbit_features_calculator
doc: "A tool for calculating features (NEDBIT). Note: The provided text contains system
  error messages regarding a container build failure and does not include usage instructions
  or argument definitions.\n\nTool homepage: https://github.com/AndMastro/NIAPU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nedbit-features-calculator:1.2--h7b50bb2_2
stdout: nedbit-features-calculator_nedbit_features_calculator.out
