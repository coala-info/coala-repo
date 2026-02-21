cwlVersion: v1.2
class: CommandLineTool
baseCommand: evofold2
label: evofold2
doc: "The provided text does not contain help information for evofold2; it contains
  error messages related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/jakob-skou-pedersen/phy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/evofold2:0.1--0
stdout: evofold2.out
