cwlVersion: v1.2
class: CommandLineTool
baseCommand: idemux
label: idemux
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/lexogen-tools/idemux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idemux:0.1.6--pyhdfd78af_0
stdout: idemux.out
