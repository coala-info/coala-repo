cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylornn_train_model_revb.py
label: phylornn_train_model_revb.py
doc: "A tool for training models within the PhyloRNN framework. (Note: The provided
  input text contains system error messages regarding container execution and disk
  space rather than command-line help documentation.)\n\nTool homepage: https://github.com/phyloRNN/phyloRNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylornn:1.1--pyhdfd78af_0
stdout: phylornn_train_model_revb.py.out
