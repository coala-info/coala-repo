cwlVersion: v1.2
class: CommandLineTool
baseCommand: codon-bias
label: codon-bias
doc: "A tool for analyzing codon usage bias. Note: The provided help text contains
  only system error messages regarding container execution and does not list specific
  command-line arguments.\n\nTool homepage: https://github.com/alondmnt/codon-bias"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codon-bias:0.3.5--pyhdfd78af_0
stdout: codon-bias.out
