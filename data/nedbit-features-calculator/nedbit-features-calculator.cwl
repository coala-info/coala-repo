cwlVersion: v1.2
class: CommandLineTool
baseCommand: nedbit-features-calculator
label: nedbit-features-calculator
doc: "A tool for calculating features (Note: The provided text is a container runtime
  error message and does not contain usage information or argument definitions).\n
  \nTool homepage: https://github.com/AndMastro/NIAPU"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nedbit-features-calculator:1.2--h7b50bb2_2
stdout: nedbit-features-calculator.out
