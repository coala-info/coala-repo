cwlVersion: v1.2
class: CommandLineTool
baseCommand: ervmancer
label: ervmancer
doc: "A tool for Endogenous Retrovirus (ERV) analysis (Note: The provided text contains
  error logs rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/AuslanderLab/ervmancer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ervmancer:0.0.4--pyhdfd78af_0
stdout: ervmancer.out
