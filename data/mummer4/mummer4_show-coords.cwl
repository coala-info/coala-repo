cwlVersion: v1.2
class: CommandLineTool
baseCommand: show-coords
label: mummer4_show-coords
doc: "The provided text does not contain help information for the tool. It contains
  a system error message regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://mummer4.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_show-coords.out
