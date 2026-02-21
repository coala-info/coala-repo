cwlVersion: v1.2
class: CommandLineTool
baseCommand: nspdk_run
label: nspdk_nspdk_run
doc: "Neighborhood Subgraph Pairwise Distance Kernel (NSPDK) tool. (Note: The provided
  text is a container runtime error log and does not contain usage instructions or
  argument definitions).\n\nTool homepage: https://github.com/aigulkhkmv/nspdk-features"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nspdk:9.2--1
stdout: nspdk_nspdk_run.out
