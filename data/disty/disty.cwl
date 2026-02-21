cwlVersion: v1.2
class: CommandLineTool
baseCommand: disty
label: disty
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime environment failure
  (no space left on device).\n\nTool homepage: https://github.com/c2-d2/disty"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/disty:0.1.0--1
stdout: disty.out
