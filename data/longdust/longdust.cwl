cwlVersion: v1.2
class: CommandLineTool
baseCommand: longdust
label: longdust
doc: "The provided text does not contain help information or a description of the
  tool; it is a system error log indicating a failure to build a container image due
  to insufficient disk space.\n\nTool homepage: https://github.com/lh3/longdust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longdust:1.4--h577a1d6_0
stdout: longdust.out
