cwlVersion: v1.2
class: CommandLineTool
baseCommand: grimer
label: grimer
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log errors regarding disk space.\n\nTool homepage:
  https://github.com/pirovc/grimer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grimer:1.1.0--pyhdfd78af_0
stdout: grimer.out
