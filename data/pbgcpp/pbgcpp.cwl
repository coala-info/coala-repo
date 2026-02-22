cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbgcpp
label: pbgcpp
doc: "The provided text does not contain help information for pbgcpp; it contains
  system error messages regarding disk space and container image conversion.\n\nTool
  homepage: https://github.com/PacificBiosciences/pbbioconda"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbgcpp:2.0.2--h9ee0642_1
stdout: pbgcpp.out
