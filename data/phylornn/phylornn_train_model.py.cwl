cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylornn_train_model.py
label: phylornn_train_model.py
doc: "Train a model using PhyloRNN. (Note: The provided help text contains system
  error messages regarding disk space and container image pulling rather than the
  tool's usage information.)\n\nTool homepage: https://github.com/phyloRNN/phyloRNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylornn:1.1--pyhdfd78af_0
stdout: phylornn_train_model.py.out
