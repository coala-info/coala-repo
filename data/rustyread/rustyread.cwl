cwlVersion: v1.2
class: CommandLineTool
baseCommand: rustyread
label: rustyread
doc: "The provided text does not contain help information or a description for the
  tool; it is a log of a failed container image retrieval.\n\nTool homepage: https://github.com/natir/rustyread"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustyread:0.4.1--heebf65f_4
stdout: rustyread.out
