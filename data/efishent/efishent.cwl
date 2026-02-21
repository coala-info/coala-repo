cwlVersion: v1.2
class: CommandLineTool
baseCommand: efishent
label: efishent
doc: "Efficient FISH (Fluorescence In Situ Hybridization) probe design tool. Note:
  The provided help text contains only system error logs regarding container image
  building and does not list specific command-line arguments.\n\nTool homepage: https://github.com/bbquercus/eFISHent/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/efishent:0.0.5--pyhdfd78af_0
stdout: efishent.out
