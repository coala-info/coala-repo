cwlVersion: v1.2
class: CommandLineTool
baseCommand: lorikeet
label: lorikeet
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error regarding a container build failure (no space left
  on device).\n\nTool homepage: https://github.com/AbeelLab/lorikeet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorikeet:20
stdout: lorikeet.out
