cwlVersion: v1.2
class: CommandLineTool
baseCommand: dna-nn
label: dna-nn
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/lh3/dna-nn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dna-nn:0.1--h077b44d_3
stdout: dna-nn.out
