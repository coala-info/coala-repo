cwlVersion: v1.2
class: CommandLineTool
baseCommand: nlstradamus
label: nlstradamus
doc: "A tool for predicting Nuclear Localization Signals (NLS). (Note: The provided
  text contains container runtime errors and does not list specific command-line arguments.)\n
  \nTool homepage: https://github.com/0xLJoseb/Bact2Nuc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nlstradamus:1.8--0
stdout: nlstradamus.out
