cwlVersion: v1.2
class: CommandLineTool
baseCommand: muset
label: muset
doc: "A tool for MuSEt (Multi-Sample Somatic Mutation Calling). Note: The provided
  help text contains only system error messages regarding container image creation
  and does not list specific command-line arguments.\n\nTool homepage: https://github.com/CamilaDuitama/muset"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muset:0.5.1--h22625ea_0
stdout: muset.out
