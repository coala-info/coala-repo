cwlVersion: v1.2
class: CommandLineTool
baseCommand: grf-main
label: genericrepeatfinder_grf-main
doc: "Generic Repeat Finder (Note: The provided help text contains only system error
  messages regarding container execution and does not list tool-specific arguments).\n
  \nTool homepage: https://github.com/bioinfolabmu/GenericRepeatFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genericrepeatfinder:1.0.2--h9948957_1
stdout: genericrepeatfinder_grf-main.out
