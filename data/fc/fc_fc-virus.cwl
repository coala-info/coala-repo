cwlVersion: v1.2
class: CommandLineTool
baseCommand: fc
label: fc_fc-virus
doc: "The provided text does not contain help information for the tool. It contains
  system log messages and a fatal error regarding container image building (no space
  left on device).\n\nTool homepage: https://github.com/qdu-bioinfo/fc-virus"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fc:1.0.1--h5ca1c30_1
stdout: fc_fc-virus.out
