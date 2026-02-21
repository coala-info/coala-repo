cwlVersion: v1.2
class: CommandLineTool
baseCommand: IntaRNA
label: intarna_IntaRNAens
doc: "IntaRNA is a tool for predicting RNA-RNA interactions. (Note: The provided help
  text contains only system error messages and no usage information.)\n\nTool homepage:
  https://github.com/BackofenLab/IntaRNA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/intarna:3.4.1--pl5321h077b44d_3
stdout: intarna_IntaRNAens.out
