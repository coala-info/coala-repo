cwlVersion: v1.2
class: CommandLineTool
baseCommand: k-slam
label: k-slam
doc: "K-SLAM is a tool for metagenomic sequence classification. (Note: The provided
  help text contains system error messages and does not list specific arguments or
  usage instructions).\n\nTool homepage: https://github.com/aindj/k-SLAM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/k-slam:1.0--1
stdout: k-slam.out
