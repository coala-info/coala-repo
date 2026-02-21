cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcta
label: gcta
doc: "Genome-wide Complex Trait Analysis (Note: The provided text contains system
  error messages and does not include the tool's help documentation or usage instructions).\n
  \nTool homepage: https://cnsgenomics.com/software/gcta/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcta:1.94.1--h9ee0642_0
stdout: gcta.out
