cwlVersion: v1.2
class: CommandLineTool
baseCommand: bandage
label: bandage
doc: "The provided text is a system error log indicating a failure to build or extract
  a container image (no space left on device) and does not contain CLI help information
  or arguments.\n\nTool homepage: https://github.com/rrwick/Bandage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bandage:0.9.0--h9948957_0
stdout: bandage.out
