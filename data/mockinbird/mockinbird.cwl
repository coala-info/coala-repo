cwlVersion: v1.2
class: CommandLineTool
baseCommand: mockinbird
label: mockinbird
doc: "Modeling of CLIP-data to identify RBP binding sites (Note: The provided text
  contains only system error messages and no help documentation; therefore, no arguments
  could be extracted).\n\nTool homepage: https://github.com/soedinglab/mockinbird"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mockinbird:1.0.0a1--py35r3.4.1_0
stdout: mockinbird.out
