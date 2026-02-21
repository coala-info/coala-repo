cwlVersion: v1.2
class: CommandLineTool
baseCommand: dehomopolymerate
label: dehomopolymerate
doc: "A tool for dehomopolymerizing sequences. (Note: The provided text contains container
  runtime errors and does not include specific usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/tseemann/dehomopolymerate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dehomopolymerate:0.4.0--h577a1d6_5
stdout: dehomopolymerate.out
