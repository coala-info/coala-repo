cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcontact3
label: vcontact3
doc: "vContact3 is a tool for virus taxonomy and classification, though the provided
  text contains only container runtime error logs and no specific help documentation.\n
  \nTool homepage: https://bitbucket.org/MAVERICLab/vcontact3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcontact3:3.1.6--pyhdfd78af_0
stdout: vcontact3.out
