cwlVersion: v1.2
class: CommandLineTool
baseCommand: feems_FEEMSmix
label: feems_FEEMSmix
doc: "Fast Estimation of Effective Migration Surfaces (FEEMS). Note: The provided
  input text contains system error messages regarding container execution and does
  not list command-line arguments.\n\nTool homepage: https://github.com/NovembreLab/feems"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feems:2.0.1--pyhdfd78af_0
stdout: feems_FEEMSmix.out
