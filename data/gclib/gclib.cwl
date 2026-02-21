cwlVersion: v1.2
class: CommandLineTool
baseCommand: gclib
label: gclib
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/gpertea/gclib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gclib:0.0.1--4
stdout: gclib.out
