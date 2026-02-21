cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimac4
label: minimac4
doc: "The provided text does not contain help information for minimac4; it contains
  system logs and a fatal error regarding container execution (no space left on device).\n
  \nTool homepage: https://github.com/statgen/Minimac4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimac4:4.1.6--hcb620b3_1
stdout: minimac4.out
