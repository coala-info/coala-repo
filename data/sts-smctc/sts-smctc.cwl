cwlVersion: v1.2
class: CommandLineTool
baseCommand: sts-smctc
label: sts-smctc
doc: "Sequential Monte Carlo for Tissue Composition (STS-SMCTC) tool.\n\nTool homepage:
  https://github.com/matsengrp/smctc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sts-smctc:1.0--h0704011_13
stdout: sts-smctc.out
