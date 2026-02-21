cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dna-nn
  - gen-fq
label: dna-nn_gen-fq
doc: "A tool from the dna-nn package, likely used for generating FastQ files using
  neural networks. Note: The provided help text contains only system error messages
  regarding container execution and does not list specific arguments.\n\nTool homepage:
  https://github.com/lh3/dna-nn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dna-nn:0.1--h077b44d_3
stdout: dna-nn_gen-fq.out
