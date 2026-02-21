cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedgovcf
label: bedgovcf
doc: "A tool for converting BED files to VCF format (Note: The provided text contains
  only system error logs and no help documentation; arguments could not be extracted).\n
  \nTool homepage: https://github.com/nvnieuwk/bedgovcf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedgovcf:0.1.1--h9ee0642_0
stdout: bedgovcf.out
