cwlVersion: v1.2
class: CommandLineTool
baseCommand: lima
label: lima
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error messages.\n\nTool homepage: https://github.com/PacificBiosciences/barcoding"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lima:2.13.0--h9ee0642_0
stdout: lima.out
