cwlVersion: v1.2
class: CommandLineTool
baseCommand: feems
label: feems
doc: "Fast Estimation of Effective Migration Surfaces (FEEMS) is a method for visualizing
  spatial genetic structure.\n\nTool homepage: https://github.com/NovembreLab/feems"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feems:2.0.1--pyhdfd78af_0
stdout: feems.out
