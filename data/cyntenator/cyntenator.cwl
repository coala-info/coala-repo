cwlVersion: v1.2
class: CommandLineTool
baseCommand: cyntenator
label: cyntenator
doc: "A tool for synteny alignment (Note: The provided text contains container build
  errors and no help documentation; therefore, no arguments could be extracted).\n
  \nTool homepage: https://github.com/dieterich-lab/cyntenator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cyntenator:0.0.r2326--h9948957_4
stdout: cyntenator.out
