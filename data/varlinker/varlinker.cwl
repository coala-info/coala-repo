cwlVersion: v1.2
class: CommandLineTool
baseCommand: varlinker
label: varlinker
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container image retrieval.\n\nTool homepage: https://github.com/IBCHgenomic/varlinker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varlinker:0.1.0--h4349ce8_0
stdout: varlinker.out
