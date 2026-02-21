cwlVersion: v1.2
class: CommandLineTool
baseCommand: feems_run.py
label: feems_run.py
doc: "Fast Estimation of Effective Migration Surfaces (feems)\n\nTool homepage: https://github.com/NovembreLab/feems"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feems:2.0.1--pyhdfd78af_0
stdout: feems_run.py.out
