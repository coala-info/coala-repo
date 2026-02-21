cwlVersion: v1.2
class: CommandLineTool
baseCommand: hubward-all
label: hubward-all
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/lh3/bwa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward-all:0.2.1--1
stdout: hubward-all.out
