cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmnrandomread
label: hmnrandomread
doc: "The provided text does not contain help information or usage instructions for
  the tool. It is a system error log indicating a failure to build a container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/guillaume-gricourt/HmnRandomRead"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnrandomread:0.10.0--h9948957_4
stdout: hmnrandomread.out
