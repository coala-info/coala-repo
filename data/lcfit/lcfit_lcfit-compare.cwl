cwlVersion: v1.2
class: CommandLineTool
baseCommand: lcfit-compare
label: lcfit_lcfit-compare
doc: "The provided text does not contain help information for the tool. It contains
  system error messages regarding container image conversion and storage issues.\n
  \nTool homepage: https://github.com/matsengrp/lcfit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lcfit:0.5--h20b91ae_3
stdout: lcfit_lcfit-compare.out
