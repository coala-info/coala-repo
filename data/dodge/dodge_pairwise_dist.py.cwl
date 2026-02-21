cwlVersion: v1.2
class: CommandLineTool
baseCommand: dodge_pairwise_dist.py
label: dodge_pairwise_dist.py
doc: "A tool for calculating pairwise distances (Note: The provided help text contains
  only system error messages and no usage information).\n\nTool homepage: https://github.com/LanLab/dodge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dodge:1.0.1--pyhdfd78af_0
stdout: dodge_pairwise_dist.py.out
