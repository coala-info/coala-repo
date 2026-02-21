cwlVersion: v1.2
class: CommandLineTool
baseCommand: portello
label: portello
doc: "Portello is a tool for processing and analyzing genomic data (description based
  on tool name hint as the provided text contains only container build logs).\n\n
  Tool homepage: https://github.com/PacificBiosciences/portello"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/portello:0.7.0--h9ee0642_0
stdout: portello.out
