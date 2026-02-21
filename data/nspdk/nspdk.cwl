cwlVersion: v1.2
class: CommandLineTool
baseCommand: nspdk
label: nspdk
doc: "Neighborhood Subgraph Pairwise Distance Kernel (NSPDK) tool. Note: The provided
  help text contains only system error messages regarding container execution and
  does not list specific command-line arguments.\n\nTool homepage: https://github.com/aigulkhkmv/nspdk-features"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nspdk:9.2--1
stdout: nspdk.out
