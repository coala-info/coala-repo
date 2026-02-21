cwlVersion: v1.2
class: CommandLineTool
baseCommand: mikrokondo-tools
label: mikrokondo-tools
doc: "The provided text does not contain help information or usage instructions. It
  consists of container runtime log messages and a fatal error indicating a failure
  to build the SIF image due to insufficient disk space.\n\nTool homepage: https://pypi.org/project/mikrokondo-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikrokondo-tools:0.0.1rc0--pyhdfd78af_0
stdout: mikrokondo-tools.out
