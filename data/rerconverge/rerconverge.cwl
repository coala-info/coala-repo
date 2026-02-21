cwlVersion: v1.2
class: CommandLineTool
baseCommand: rerconverge
label: rerconverge
doc: "RERconverge is an R package for finding associations between relative evolutionary
  rates (RERs) and phenotype evolution.\n\nTool homepage: https://github.com/nclark-lab/RERconverge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rerconverge:0.3.0--r44h7b50bb2_3
stdout: rerconverge.out
