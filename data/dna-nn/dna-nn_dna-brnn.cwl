cwlVersion: v1.2
class: CommandLineTool
baseCommand: dna-brnn
label: dna-nn_dna-brnn
doc: "A tool for DNA sequence classification using Recurrent Neural Networks (Note:
  The provided help text contains only container runtime error logs and no usage information).\n
  \nTool homepage: https://github.com/lh3/dna-nn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dna-nn:0.1--h077b44d_3
stdout: dna-nn_dna-brnn.out
