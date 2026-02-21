cwlVersion: v1.2
class: CommandLineTool
baseCommand: lcfit
label: lcfit
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime environment.\n\nTool homepage:
  https://github.com/matsengrp/lcfit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lcfit:0.5--h20b91ae_3
stdout: lcfit.out
