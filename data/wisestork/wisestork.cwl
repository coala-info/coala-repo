cwlVersion: v1.2
class: CommandLineTool
baseCommand: wisestork
label: wisestork
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/sndrtj/wisestork"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wisestork:0.1.2--pyh24bf2e0_0
stdout: wisestork.out
