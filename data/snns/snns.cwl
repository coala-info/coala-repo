cwlVersion: v1.2
class: CommandLineTool
baseCommand: snns
label: snns
doc: "Stuttgart Neural Network Simulator (Note: The provided text is a container engine
  error log and does not contain the tool's help documentation or argument definitions).\n
  \nTool homepage: https://github.com/bioinf-jku/SNNs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snns:4.3--1
stdout: snns.out
