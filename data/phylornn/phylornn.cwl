cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylornn
label: phylornn
doc: "PhyloRNN is a tool for phylogenetic analysis using Recurrent Neural Networks.
  (Note: The provided text contains system error messages regarding disk space and
  container initialization rather than the tool's help documentation.)\n\nTool homepage:
  https://github.com/phyloRNN/phyloRNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylornn:1.1--pyhdfd78af_0
stdout: phylornn.out
