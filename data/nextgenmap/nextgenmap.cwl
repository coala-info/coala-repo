cwlVersion: v1.2
class: CommandLineTool
baseCommand: nextgenmap
label: nextgenmap
doc: "The provided text does not contain help information for nextgenmap; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/philres/NextGenMap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextgenmap:0.5.5--h2d50403_2
stdout: nextgenmap.out
