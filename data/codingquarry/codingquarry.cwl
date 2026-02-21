cwlVersion: v1.2
class: CommandLineTool
baseCommand: CodingQuarry
label: codingquarry
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error regarding container image building (no space left
  on device).\n\nTool homepage: https://sourceforge.net/p/codingquarry/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codingquarry:2.0--py311he264feb_11
stdout: codingquarry.out
