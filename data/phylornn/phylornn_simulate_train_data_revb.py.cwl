cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylornn_simulate_train_data_revb.py
label: phylornn_simulate_train_data_revb.py
doc: "A tool for simulating training data for PhyloRNN. Note: The provided input text
  contains system error messages regarding disk space and container image building
  rather than the tool's help documentation.\n\nTool homepage: https://github.com/phyloRNN/phyloRNN"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylornn:1.1--pyhdfd78af_0
stdout: phylornn_simulate_train_data_revb.py.out
